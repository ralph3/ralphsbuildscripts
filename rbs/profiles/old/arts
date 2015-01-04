#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.5.8"

DIR="arts-${VERSION}"
TARBALL="arts-${VERSION}.tar.bz2"

DEPENDS=(
  alsa-lib
  audiofile
  esound
  libmad
  libvorbis
  qt
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
061ce49351d970a81f4c0a1b0339fb34
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/artsc-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='arts-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/arts-%version%.tar.bz2'
  )
}
