#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.23"

DIR="alsa-utils-${VERSION}"
TARBALL="alsa-utils-${VERSION}.tar.bz2"

DEPENDS=(
  alsa-lib
  ncurses
  xmlto
)

SRC1=(
http://ftp.silug.org/pub/alsa/utils/${TARBALL}
ftp://ftp.alsa-project.org/pub/utils/${TARBALL}
)

MD5SUMS=(
cb0cf46029ac9549cf3a31bff6a4f4e1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD -DENABLE_NLS" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/etc/rc.d || return 1
cat << "EOF" >$TMPROOT/etc/rc.d/rc.alsa
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case "$1" in
  start)
    print_msg "Starting ALSA..."
    loadproc alsactl restore
  ;;
  stop)
    print_msg "Stopping ALSA..."
    loadproc alsactl store
  ;;
  restart)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    return 1
  ;;
esac
EOF
  chmod 744 $TMPROOT/etc/rc.d/rc.alsa || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  [ ! -e "/etc/asound.state" ] && >/etc/asound.state
  alsactl store
  return 0
}

version_check_info(){
  ADDRESS='http://ftp.silug.org/pub/alsa/utils/'
  VERSION_STRING='alsa-utils-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://ftp.silug.org/pub/alsa/utils/alsa-utils-%version%.tar.bz2'
  )
}