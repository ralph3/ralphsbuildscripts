#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.0"

DIR="libXfont-${VERSION}"
TARBALL="libXfont-${VERSION}.tar.bz2"

DEPENDS=(
  fontcacheproto
  fontsproto
  freetype
  libfontenc
  xtrans
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
3a8e06b25912ef339d70a8ba003da9b5
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='libXfont-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXfont-%version%.tar.bz2'
  )
}
