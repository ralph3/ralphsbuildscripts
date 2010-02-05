#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.38"

ONLY32=1

DIR="wine-${VERSION}"
TARBALL="wine-${VERSION}.tar.bz2"

DEPENDS=(
  fontconfig
  hal
  lcms
  libjpeg
  libpng
  libxcomposite
  libxcursor
  libxinerama
  libxml2
  libxslt
  ncurses
  openssl
)

SRC1=(
http://ibiblio.org/pub/linux/system/emulators/wine/${TARBALL}
)

MD5SUMS=(
ef5947bcb9667b75b8de4a2ce16d0ec2
)

build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ibiblio.org/pub/linux/system/emulators/wine/'
  VERSION_STRING='wine-%version%.tar.bz2'
  MIRRORS=(
    'http://ibiblio.org/pub/linux/system/emulators/wine/wine-%version%.tar.bz2'
  )
}
