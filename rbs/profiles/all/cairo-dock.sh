#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.3-7"

DIR="cairo-dock-${VERSION}"
TARBALL="cairo-dock-${VERSION}.tar.gz"

DEPENDS=(
  gtkglext
)

SRC1=(
http://launchpad.net/cairo-dock-core/$(echo $VERSION | cut -f-2 -d'.')/$(echo $VERSION | cut -f1 -d'-')/+download/${TARBALL}
)

MD5SUMS=(
2d1c60d74fb5f49a56f6b0b2f45e628d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ####
  #
  # GTK 2.20.* fix
  #
  sed -i -e 's%GTK_WIDGET_REALIZED%gtk_widget_get_realized%g' \
    src/cairo-dock-draw-opengl.c || return 1
  #
  #####
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
