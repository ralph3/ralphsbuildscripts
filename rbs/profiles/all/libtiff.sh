#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.9.0"

DIR="tiff-${VERSION}"
TARBALL="tiff-${VERSION}.tar.gz"

DEPENDS=(
  libjpeg
  mesa
  zlib
)

SRC1=(
ftp://ftp.remotesensing.org/libtiff/${TARBALL}
ftp://ftp.remotesensing.org/libtiff/old/${TARBALL}
)

MD5SUMS=(
74c0072edc1ac8ca6b8af009a31151e5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.remotesensing.org/libtiff/'
  VERSION_STRING='tiff-%version%.tar.gz'
  VERSION_FILTERS='alpha beta'
  MIRRORS=(
    'ftp://ftp.remotesensing.org/libtiff/tiff-%version%.tar.gz'
  )
}
