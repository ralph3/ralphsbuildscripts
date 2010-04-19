#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0+20030701"

DIR="unifdef-${VERSION}"
TARBALL="unifdef_${VERSION}.orig.tar.gz"

DEPENDS=(
  make
)

SRC1=(
  http://ftp.debian.org/debian/pool/main/u/unifdef/$TARBALL
)

MD5SUMS=(
27dfcaa64c59fbb1f8980e4e296abe39
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
  ADDRESS='http://ftp.debian.org/debian/pool/main/u/unifdef/'
  VERSION_STRING='unifdef_%version%.orig.tar.gz'
  MIRRORS=(
    'http://ftp.debian.org/debian/pool/main/u/unifdef/unifdef_%version%.orig.tar.gz'
  )
}
