#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.9.3"

DIR="pcmanfm-${VERSION}"
TARBALL="pcmanfm-${VERSION}.tar.gz"

DEPENDS=(
  libfm
)

SRC1=(
http://prdownloads.sourceforge.net/pcmanfm/${TARBALL}
)

MD5SUMS=(
a93ce99f2f14582b89e278aae95c7fa0
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
  ADDRESS="http://sourceforge.net/projects/pcmanfm/files/"
  VERSION_STRING="pcmanfm-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/pcmanfm/pcmanfm-%version%.tar.gz"
  )
}
