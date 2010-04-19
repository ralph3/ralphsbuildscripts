#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1"

DIR="gtk-qt-engine"
TARBALL="gtk-qt-engine-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
  kdebase
)

SRC1=(
http://gtk-qt.ecs.soton.ac.uk/files/$(echo $VERSION | cut -f-2 -d'.')/$TARBALL
)

MD5SUMS=(
de8048baef7dfe6c97cd97c463d66152
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gtk-qt.ecs.soton.ac.uk/files/%minor_version%/'
  VERSION_STRING='gtk-qt-engine-%version%.tar.bz2'
  MIRRORS=(
    'http://gtk-qt.ecs.soton.ac.uk/files/%minor_version%/gtk-qt-engine-%version%.tar.bz2'
  )
}
