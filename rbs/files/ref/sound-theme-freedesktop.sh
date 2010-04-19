#!/bin/bash

VERSION="0.0.0.0.1"

DIR="freedesktop"
TARBALL="sound-theme-freedesktop.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://0pointer.de/public/${TARBALL}
)

MD5SUMS=(
35f978665f0854f29a17a0974e780b1b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  mkdir -p $TMPROOT/usr/share/sounds || return 1
  cp -va $SRCDIR/$DIR $TMPROOT/usr/share/sounds/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

