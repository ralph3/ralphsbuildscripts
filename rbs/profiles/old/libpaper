#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.23"

DIR="libpaper-${VERSION}"
TARBALL="libpaper_${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.debian.org/debian/pool/main/libp/libpaper/${TARBALL}
)

MD5SUMS=(
d357ac5fd7e12b1c81b27f99665e399c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.debian.org/debian/pool/main/libp/libpaper/'
  VERSION_STRING='libpaper_%version%.tar.gz'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'http://ftp.debian.org/debian/pool/main/libp/libpaper/libpaper-%version%.tar.gz'
  )
}
