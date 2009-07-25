#!/bin/bash

VERSION="1.2.2"
SYS_VERSION="1.2.2-1"

DIR="libX11-${VERSION}"
TARBALL="libX11-${VERSION}.tar.bz2"

DEPENDS=(
  libxau
  libxcb
  libxdmcp
  xcmiscproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
94cbee7fae2ddb92b2d80116af871f54
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
  VERSION_STRING='libX11-%version%.tar.bz2'
  VERSION_FILTERS='99'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libX11-%version%.tar.bz2'
  )
}
