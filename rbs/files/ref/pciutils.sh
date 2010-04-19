#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.11"

DIR="pciutils-${VERSION}"
TARBALL="pciutils-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.kernel.org/pub/software/utils/pciutils/${TARBALL}
)

MD5SUMS=(
2b3b2147b7bc91f362be55cb49fa1c4e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" \
    CFLAGS="$CFLAGS" PREFIX=/usr || return 1
  make install PREFIX=$TMPROOT/usr ROOT=$TMPROOT/ || return 1
  mkdir -vp $TMPROOT/usr/{include/pci,${LIBSDIR}} || return 1
  install -v -m 0644 lib/*.h $TMPROOT/usr/include/pci/ || return 1
  install -v -m 0644 lib/libpci.a $TMPROOT/usr/${LIBSDIR}/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.kernel.org/pub/software/utils/pciutils/'
  VERSION_STRING='pciutils-%version%.tar.bz2'
  MINOR_VERSION='2.1'
  MIRRORS=(
    'http://ftp.kernel.org/pub/software/utils/pciutils/pciutils-%version%.tar.bz2'
  )
}
