#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.0.3"

DIR="screen-${VERSION}"
TARBALL="screen-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/screen/${TARBALL}
)

MD5SUMS=(
8506fd205028a96c741e4037de6e3c42
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  install -v -d 755 $TMPROOT/etc || return 1
  install -v -m 644 etc/etcscreenrc $TMPROOT/etc/screenrc.new || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/screen/'
  VERSION_STRING='screen-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/screen/screen-%version%.tar.gz'
  )
}
