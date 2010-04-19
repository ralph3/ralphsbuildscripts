#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.7"

DIR="libgpg-error-${VERSION}"
TARBALL="libgpg-error-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.gnupg.org/gcrypt/libgpg-error/${TARBALL}
)

MD5SUMS=(
62c0d09d1e76c5b6da8fff92314c4665
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.gnupg.org/gcrypt/libgpg-error/'
  VERSION_STRING='libgpg-error-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-%version%.tar.bz2'
  )
}
