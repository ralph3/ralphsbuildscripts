#!/bin/bash

VERSION="1.4.3"
SYS_VERSION="1.4.3-1"

DIR="cups-${VERSION}"
TARBALL="cups-${VERSION}-source.tar.bz2"

DEPENDS=(
  shadow
  libusb
)

SRC1=(
http://ftp.easysw.com/pub/cups/${VERSION}/${TARBALL}
)

MD5SUMS=(
e70b1c3f60143d7310c1d74c111a21ab
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
    
  groupadd lp
  useradd -c "Print Service User" -d /dev/null -g lp -s /bin/false lp
  sed -i -e "s@pam/pam@security/pam@g" \
    {config-scripts/cups-pam.m4,scheduler/auth.c,configure} || return 1
  sed -i "s%/lib/cups%/${LIBSDIR}/cups%g" $(grep -rl "/lib/cups" *) || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install BUILDROOT=$TMPROOT || return 1
  if [ "$LIBSDIR" != "lib" ] && [ -d "$TMPROOT/usr/lib" ]; then
    cp -a $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
    rm -rf $TMPROOT/usr/lib || return 1
  fi
  set_multiarch $TMPROOT/usr/bin/cups-config || return 1
  find $TMPROOT/etc -type d -exec chmod 755 '{}' \;
  sed -i 's%127.0.0.1%127.0.0.1 localhost%g' \
    $TMPROOT/etc/cups/cupsd.conf || return 1
  find $TMPROOT/etc/cups/* -maxdepth 0 -type f -exec mv '{}' '{}'.new \;
  rm -rf $TMPROOT/{etc/{rc.d,init.d},usr/share/applications} || return 1
  mkdir -p $TMPROOT/etc/rc.d || return 1
cat << "EOF" > $TMPROOT/etc/rc.d/rc.cups || return 1
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Starting Cups"
    loadproc /usr/sbin/cupsd
  ;;
  stop)
    print_msg "Starting Cups"
    killproc cupsd
  ;;
  restart)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: {start|stop|restart}"
    exit 1
  ;;
esac
EOF
  chmod 744 $TMPROOT/etc/rc.d/rc.cups || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

post_remove(){
  userdel lp
}

version_check_info(){
  ADDRESS='http://ftp.easysw.com/pub/cups/%version%/'
  VERSION_STRING='cups-%version%-source.tar.bz2'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'http://ftp.easysw.com/pub/cups/%version%/cups-%version%-source.tar.bz2'
  )
}
