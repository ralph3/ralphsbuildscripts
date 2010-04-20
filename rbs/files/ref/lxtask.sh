#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.3"

DIR="lxtask-${VERSION}"
TARBALL="lxtask-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
eccfb69ee1a209248b22a5f0a34a4734
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
  ADDRESS="http://sourceforge.net/projects/lxde/files/"
  VERSION_STRING="lxtask-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/lxtask-%version%.tar.gz"
  )
}
