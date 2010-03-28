#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.5"

DIR="lxpanel-${VERSION}"
TARBALL="lxpanel-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
  menu-cache
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
6162b7e8d912a41f9c075fe982370bfb
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
  ADDRESS="http://sourceforge.net/projects/lxde/files/"
  VERSION_STRING="lxpanel-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/lxpanel-%version%.tar.gz"
  )
}
