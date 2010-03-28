#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.0"

DIR="lxde-common-${VERSION}"
TARBALL="lxde-common-${VERSION}.tar.gz"

DEPENDS=(
  lxsession
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
23606ab3d6e1039386d62a4b68b4ffc6
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
  VERSION_STRING="lxde-common-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/lxde-common-%version%.tar.gz"
  )
}
