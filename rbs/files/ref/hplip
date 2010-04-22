#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.9.10"


DIR="hplip-${VERSION}"
TARBALL="hplip-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/hpinkjet/${TARBALL}
)

MD5SUMS=(
349489b10fb44d1bf105b04ff5352551
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --disable-network-build || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/hpinkjet/'
  VERSION_STRING='hplip-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/hpinkjet/hplip-%version%.tar.gz'
  )
}
