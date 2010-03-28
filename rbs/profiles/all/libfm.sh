#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.9"

DIR="libfm-${VERSION}"
TARBALL="libfm-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/pcmanfm/${TARBALL}
)

MD5SUMS=(
023781719c6f1f2734cc0dedf48a920a
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
  VERSION_STRING="libfm-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/pcmanfm/libfm-%version%.tar.gz"
  )
}
