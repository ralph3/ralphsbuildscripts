#!/bin/bash

VERSION="0.7.1"
SYS_VERSION="0.7.1-2"

DIR="rarian-${VERSION}"
TARBALL="rarian-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://rarian.freedesktop.org/Releases/${TARBALL}
)

MD5SUMS=(
f2a2755d62cecc717af2b5432ae0f390
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's%^#ifndef I_KNOW_RARIAN%#ifdef I_KNOW_RARIAN_foo_%' \
    librarian/*.h || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://rarian.freedesktop.org/Releases/'
  VERSION_STRING='rarian-%version%.tar.bz2'
  MIRRORS=(
    'http://rarian.freedesktop.org/Releases/rarian-%version%.tar.bz2'
  )
}
