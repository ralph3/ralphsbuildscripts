#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.4"

DIR="wv-${VERSION}"
TARBALL="wv-${VERSION}.tar.gz"

DEPENDS=(
  libgsf
  libwmf
  libpng
)

SRC1=(
http://prdownloads.sourceforge.net/wvware/${TARBALL}
)

MD5SUMS=(
c1861c560491f121e12917fa76970ac5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/wvware/'
  VERSION_STRING='wv-%version%.tar.gz'
  MINOR_VERSION="1"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/wvware/wv-%version%.tar.gz"
  )
}
