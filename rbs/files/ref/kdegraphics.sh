#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.0"

DIR="kdegraphics-${VERSION}"
TARBALL="kdegraphics-${VERSION}.tar.bz2"

DEPENDS=(
  fribidi
  imlib
  kdebase
  lcms
  libpaper
  poppler
  sane-backends
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
8beb6fe5d475d0b0245ea6d4cc7e9732
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  if [ "$LIBSDIR" != "lib64" ] && [ -n "$(grep -rl '\-L/usr/lib64' *)" ]; then
    sed -i "s%-L/usr/lib64%-L/usr/${LIBSDIR}%g" \
      $(grep -rl '\-L/usr/lib64' *) || return 1
  fi
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='kdegraphics-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/kdegraphics-%version%.tar.bz2'
  )
}
