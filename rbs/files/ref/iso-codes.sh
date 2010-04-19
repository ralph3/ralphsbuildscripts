#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.6"

DIR="iso-codes-${VERSION}"
TARBALL="iso-codes_${VERSION}.orig.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.debian.org/debian/pool/main/i/iso-codes/${TARBALL}
)

MD5SUMS=(
3060e0c2ac0a9366b32427e4ceabbce9
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
  ADDRESS='http://ftp.debian.org/debian/pool/main/i/iso-codes/'
  VERSION_STRING='iso-codes_%version%.orig.tar.gz'
  MIRRORS=(
    'http://ftp.debian.org/debian/pool/main/i/iso-codes/iso-codes_%version%.orig.tar.gz'
  )
}
