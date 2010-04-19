#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.0"


DIR="compiz-${VERSION}"
TARBALL="compiz-${VERSION}.tar.bz2"

DEPENDS=(
  libxdamage
  libxinerama
  startup-notification
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
7a35a9f52155b945aa195f826d3d607a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo '#include <GL/glxtokens.h>' > include/compiz.h.new || return 1
  cat include/compiz.h >> include/compiz.h.new || return 1
  mv include/compiz.h.new include/compiz.h || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/app/'
  VERSION_STRING='compiz-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/compiz-%version%.tar.bz2'
  )
}
