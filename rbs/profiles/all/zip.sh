#!/bin/bash

DISABLE_MULTILIB=1

VERSION="232"

APPVERSION="$(echo $VERSION | cut -b1).$(echo $VERSION | cut -b2-)"
DIR="zip-${APPVERSION}"
TARBALL="zip${VERSION}.tar.gz"

DEPENDS=(
  make
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e 's@$(INSTALL) man/zip.1@$(INSTALL_PROGRAM) man/zip.1@' \
    -e "s@^CFLAGS = @& $CFLAGS @" unix/Makefile || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" prefix=/usr \
    -f unix/Makefile generic_gcc || return 1
  make prefix=$TMPROOT/usr -f unix/Makefile install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
