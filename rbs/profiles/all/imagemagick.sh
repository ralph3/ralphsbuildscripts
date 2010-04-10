#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6.6.1-2"

DIR="ImageMagick-${VERSION}"
TARBALL="ImageMagick-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.imagemagick.org/pub/ImageMagick/${TARBALL}
)

MD5SUMS=(
1cd50408d5587463fb5d124876eaade8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" LDFLAGS="-L/usr/${LIBSDIR}" ./configure \
    $CONF --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/{Magick,Magick++,Wand}-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.imagemagick.org/pub/ImageMagick/'
  VERSION_STRING='ImageMagick-%version%.tar.bz2'
  VERSION_FILTERS='[0-9][0-9][0-9][0-9]'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick-%version%.tar.bz2'
  )
}
