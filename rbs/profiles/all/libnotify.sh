#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.4.4"

DIR="libnotify-${VERSION}"
TARBALL="libnotify-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

#SRC1=(
#http://www.galago-project.org/files/releases/source/libnotify/${TARBALL}
#)

#MD5SUMS=(
#0
#)

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

#version_check_info(){
#  ADDRESS='http://www.galago-project.org/files/releases/source/libnotify/'
#  VERSION_STRING='libnotify-%version%.tar.gz'
#  MIRRORS=(
#    "http://www.galago-project.org/files/releases/source/libnotify/libnotify-%version%.tar.gz"
#  )
#}
