#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.3"

DIR="obconf-${VERSION}"
TARBALL="obconf-${VERSION}.tar.gz"

DEPENDS=(
  openbox
  libglade
)

SRC1=(
http://openbox.org/dist/obconf/${TARBALL}
)

MD5SUMS=(
b22e273721851dedad72acbc77eefb68
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://openbox.org/dist/obconf"
  VERSION_STRING="obconf-%version%.tar.gz"
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    "http://openbox.org/dist/obconf/obconf-%version%.tar.gz"
  )
}
