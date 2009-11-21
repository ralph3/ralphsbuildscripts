#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.12.2"

DIR="poppler-${VERSION}"
TARBALL="poppler-${VERSION}.tar.gz"

DEPENDS=(
  cairo
  glib
  libpng
  zlib
)

SRC1=(
http://www.vi.kernel.org/pub/mirrors/gentoo/source/distfiles/$TARBALL
http://poppler.freedesktop.org/${TARBALL}
)

MD5SUMS=(
60c00b55acf7dd389bf256d178af70bf
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-xpdf-headers --enable-zlib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://poppler.freedesktop.org/'
  VERSION_STRING='poppler-%version%.tar.gz'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://poppler.freedesktop.org/poppler-%version%.tar.gz'
  )
}
