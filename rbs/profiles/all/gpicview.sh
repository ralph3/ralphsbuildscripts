#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.1"
SYS_VERSION="0.2.1-2"

DIR="gpicview-${VERSION}"
TARBALL="gpicview-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
a2de255bf9bdc40746c0dc89b3454a10
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  sed -i '/Categories=/d' $TMPROOT/usr/share/applications/gpicview.desktop || return 1
  echo 'Categories=Application;Graphics;' >> \
    $TMPROOT/usr/share/applications/gpicview.desktop || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/projects/lxde/files/'
  VERSION_STRING='gpicview-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/lxde/gpicview-%version%.tar.gz'
  )
}
