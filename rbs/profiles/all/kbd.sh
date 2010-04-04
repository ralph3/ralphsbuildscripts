#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.15.1"

DIR="kbd-${VERSION}"
TARBALL="kbd-${VERSION}.tar.gz"

DEPENDS=(
  flex
)

SRC1=(
http://ftp.altlinux.org/pub/people/legion/kbd/${TARBALL}
)

MD5SUMS=(
f997c490fe5ede839aacf31da6c4eb06
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  autoreconf || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/bin || return 1
  mv -v $TMPROOT/usr/bin/{kbd_mode,dumpkeys,loadkeys,openvt,setfont} \
    $TMPROOT/bin || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.altlinux.org/pub/people/legion/kbd/'
  VERSION_STRING='kbd-%version%.tar.gz'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://ftp.altlinux.org/pub/people/legion/kbd/kbd-%version%.tar.gz'
  )
}
