#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.4"

DIR="giblib-${VERSION}"
TARBALL="giblib-${VERSION}.tar.gz"

DEPENDS=(
  imlib2
)

SRC1=(
http://linuxbrit.co.uk/downloads/${TARBALL}
)

MD5SUMS=(
c810ef5389baf24882a1caca2954385e
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
  ADDRESS="http://linuxbrit.co.uk/downloads/"
  VERSION_STRING="giblib-%version%.tar.gz"
  MIRRORS=(
    "http://linuxbrit.co.uk/downloads/giblib-%version%.tar.gz"
  )
}