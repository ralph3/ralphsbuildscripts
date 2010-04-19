#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.0"

DIR="kdeutils-${VERSION}"
TARBALL="kdeutils-${VERSION}.tar.bz2"

DEPENDS=(
  kdebase
  gmp
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
f0ca24c7d3e5bb0ab55bf6b26fc6224e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure  --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='kdeutils-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/kdeutils-%version%.tar.bz2'
  )
}
