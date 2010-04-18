#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.4"

DIR="feh-${VERSION}"
TARBALL="feh-${VERSION}.tar.gz"

DEPENDS=(
  giblib
)

SRC1=(
http://linuxbrit.co.uk/downloads/${TARBALL}
)

MD5SUMS=(
3d35ba3d2f0693b019800787f1103891
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
  ADDRESS="http://linuxbrit.co.uk/downloads/"
  VERSION_STRING="feh-%version%.tar.gz"
  MIRRORS=(
    "http://linuxbrit.co.uk/downloads/feh-%version%.tar.gz"
  )
}