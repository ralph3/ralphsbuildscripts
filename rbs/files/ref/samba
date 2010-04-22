#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.3.0"

DIR="samba-${VERSION}"
TARBALL="samba-${VERSION}.tar.gz"

DEPENDS=(
  cups
)

SRC1=(
http://us1.samba.org/samba/ftp/${TARBALL}
http://us1.samba.org/samba/ftp/old-versions/${TARBALL}
)

MD5SUMS=(
adb048dc3988055533e1ea5d91d81f99
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR/source || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --with-libdir=/usr/$LIBSDIR/samba \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --with-piddir=/var/run \
    --with-fhs \
    --with-smbmount \
    --without-mysql \
    --with-pam \
    --with-python || return 1
  make || return 1
  install -v -m755 -d $TMPROOT/var/cache/samba || return 1
  make install DESTDIR=$TMPROOT || return 1
  chmod -v 644 $TMPROOT/usr/include/libsmbclient.h || return 1
  install -v -m755 -d $TMPROOT/$LIBSDIR || return 1
  install -v -m755 nsswitch/libnss_win{s,bind}.so $TMPROOT/$LIBSDIR || return 1
  ln -v -sf libnss_winbind.so $TMPROOT/$LIBSDIR/libnss_winbind.so.2 || return 1
  ln -v -sf libnss_wins.so $TMPROOT/$LIBSDIR/libnss_wins.so.2 || return 1
  if [ -f "nsswitch/pam_winbind.so" ]; then
    mkdir -p $TMPROOT/$LIBSDIR/security || return 1
    install -v -m755 nsswitch/pam_winbind.so \
      $TMPROOT/$LIBSDIR/security || return 1
  fi
  install -v -m644 ../examples/smb.conf.default $TMPROOT/etc/samba || return 1
  install -v -m644 ../docs/*.pdf $TMPROOT/usr/share/samba || return 1
  mkdir -p $TMPROOT/etc/rc.d || return 1
cat << "EOF" > $TMPROOT/etc/rc.d/rc.samba
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

CUPSRC='/etc/rc.d/rc.cups'

case $1 in
  start)
    [ -e "$CUPSRC" ] && {
      [ -z "$(pidof cupsd)" ] && {
        [ -x "$CUPSRC" ] && $CUPSRC start
      }
      if [ -z "$(pidof cupsd)" ]; then
        print_msg "Starting Samba"
       print_msg_failed
cat << "WWEOF" >/dev/stderr

   cupsd is not running! Cups **MUST** be started before samba.

WWEOF
        sleep 5
        exit 1
      fi
    }
    print_msg "Starting Samba: nmbd"
    /usr/sbin/nmbd -D
    evaluate_retval
    print_msg "Starting Samba: smbd"
    /usr/sbin/smbd -D
    evaluate_retval
  ;;
  stop)
    print_msg "Stopping Samba: smbd"
    killproc smbd
    print_msg "Stopping Samba: nmbd"
    killproc nmbd
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
  chmod 744 $TMPROOT/etc/rc.d/rc.samba || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://us1.samba.org/samba/ftp/'
  VERSION_STRING='samba-%version%.tar.gz'
  MIRRORS=(
    'http://us1.samba.org/samba/ftp/samba-%version%.tar.gz'
  )
}
