#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.10"

TARBALL="mpg321-${VERSION}.tar.gz"

DEPENDS=(
  libao
)

SRC1=(
http://prdownloads.sourceforge.net/mpg321/${TARBALL}
)

MD5SUMS=(
bb403b35c2d25655d55f0f616b8f47bb
)

build(){
  DIR=$(get_tarball_dir $DOWNLOADDIR/$TARBALL)
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/mpg321/'
  VERSION_STRING='mpg321-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/mpg321/mpg321-%version%.tar.gz"
  )
}
