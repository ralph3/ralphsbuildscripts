#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.5"

DIR="speex-${VERSION}"
TARBALL="speex-${VERSION}.tar.gz"

DEPENDS=(
  libogg
)

SRC1=(
http://downloads.us.xiph.org/releases/speex/${TARBALL}
)

MD5SUMS=(
01d6a2de0a88a861304bf517615dea79
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-ogg-libraries=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.speex.org/download.html'
  VERSION_STRING='speex-%version%.tar.gz'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://downloads.us.xiph.org/releases/speex/speex-%version%.tar.gz'
  )
}
