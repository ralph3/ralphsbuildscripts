#!/bin/bash

DISABLE_MULTILIB=1

# version 4.1 depends on newer xextproto >= 7.0.99.1
# AND newer xextproto breaks liblbxutil by removing
# lbxbufstr.h wait on newer liblbxutil

VERSION="4.0"

DIR="fixesproto-${VERSION}"
TARBALL="fixesproto-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/proto/${TARBALL}
)

MD5SUMS=(
8b298cc3424597f8138c7faf7763dce9
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/proto/'
  VERSION_STRING='fixesproto-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/proto/fixesproto-%version%.tar.bz2'
  )
}
