#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.46"

DIR="inkscape-${VERSION}"
TARBALL="inkscape-${VERSION}.tar.bz2"

DEPENDS=(
  gc
  gnome-vfs
  gtkmm
  gtkspell
  lcms
  libxslt
  popt
  python
)

SRC1=(
http://prdownloads.sourceforge.net/inkscape/${TARBALL}
)

MD5SUMS=(
59997096c3640b2601c2b4afba8a3d75
)

build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-python || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/inkscape/'
  VERSION_STRING='inkscape-%version%.tar.bz2'
  VERSION_FILTERS='pre'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/inkscape/inkscape-%version%.tar.bz2'
  )
}
