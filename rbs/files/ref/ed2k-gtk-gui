#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.6.4"

DIR="ed2k-gtk-gui-${VERSION}"
TARBALL="ed2k-gtk-gui-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/ed2k-gtk-gui/${TARBALL}
)

MD5SUMS=(
c51ddfc64ba39e2bb5383a95afe72c53
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/ed2k-gtk-gui/'
  VERSION_STRING='ed2k-gtk-gui-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/ed2k-gtk-gui/ed2k-gtk-gui-%version%.tar.gz'
  )
}
