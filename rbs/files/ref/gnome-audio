#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.22.2"

DIR="gnome-audio-${VERSION}"
TARBALL="gnome-audio-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-audio)
)

MD5SUMS=(
51d4a50b8927cc8a4cc52cee498e9d01
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make datadir=$TMPROOT/usr/share install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-audio/%minor_version%/'
  VERSION_STRING='gnome-audio-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-audio/%minor_version%/gnome-audio-%version%.tar.bz2'
  )
}
