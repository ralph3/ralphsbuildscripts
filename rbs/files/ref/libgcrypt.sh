#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.5"

DIR="libgcrypt-${VERSION}"
TARBALL="libgcrypt-${VERSION}.tar.bz2"

DEPENDS=(
  libgpg-error
)

SRC1=(
ftp://ftp.gnupg.org/gcrypt/libgcrypt/${TARBALL}
)

MD5SUMS=(
cc2017ad09b4543f8b3b5e9a53cfd89d
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
  ADDRESS='ftp://ftp.gnupg.org/gcrypt/libgcrypt/'
  VERSION_STRING='libgcrypt-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-%version%.tar.bz2'
  )
}
