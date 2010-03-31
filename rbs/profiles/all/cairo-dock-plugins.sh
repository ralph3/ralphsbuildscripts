#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.3-7"

DIR="cairo-dock-plugins-${VERSION}"
TARBALL="cairo-dock-plugins-${VERSION}.tar.gz"

DEPENDS=(
  cairo-dock
)

SRC1=(
http://launchpad.net/cairo-dock-plug-ins/$(echo $VERSION | cut -f-2 -d'.')/$(echo $VERSION | cut -f1 -d'-')/+download/${TARBALL}
)

MD5SUMS=(
e16f4d71a5c751bd580834a55af98ab9
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
