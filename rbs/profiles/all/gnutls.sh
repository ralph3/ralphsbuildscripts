#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.8.4"

DIR="gnutls-${VERSION}"
TARBALL="gnutls-${VERSION}.tar.bz2"

DEPENDS=(
  libgcrypt
)

SRC1=(
ftp://ftp.gnupg.org/gcrypt/gnutls/${TARBALL}
)

MD5SUMS=(
aafba37c0993595ba2ab98587b57a3de
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
  ADDRESS='ftp://ftp.gnupg.org/gcrypt/gnutls/'
  VERSION_STRING='gnutls-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.gnupg.org/gcrypt/gnutls/-%version%.tar.bz2'
  )
}
