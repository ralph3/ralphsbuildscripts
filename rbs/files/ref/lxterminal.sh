#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.7"
SYS_VERSION="0.1.7-2"

DIR="lxterminal-${VERSION}"
TARBALL="lxterminal-${VERSION}.tar.gz"

DEPENDS=(
  vte
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
b9123d3736c7c37a59c406ff4ee0b26c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e 's%<CTRL><SHIFT>C%<CTRL>C%' \
    -e 's%<CTRL><SHIFT>V%<CTRL>V%' \
    -e 's%<CTRL><SHIFT>T%<CTRL>T%' \
    src/lxterminal.h || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://sourceforge.net/projects/lxde/files/"
  VERSION_STRING="lxterminal-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/lxterminal-%version%.tar.gz"
  )
}
