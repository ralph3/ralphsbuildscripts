#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.15.1b"

DIR="libmad-${VERSION}"
TARBALL="libmad-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/mad/${TARBALL}
)

MD5SUMS=(
1be543bc30c56fb6bea1d7bf6a64e66c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  find -name 'Makefile' -exec sed -i 's%-fforce-mem %%g' {} \;
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=12349&package_id=86999'
  VERSION_STRING='libmad-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/mad/libmad-%version%.tar.gz"
  )
}
