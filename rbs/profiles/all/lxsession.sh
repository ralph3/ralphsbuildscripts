#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.4.3"

DIR="lxsession-${VERSION}"
TARBALL="lxsession-${VERSION}.tar.gz"

DEPENDS=(
  openbox
  obconf
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
4eb7b27bc31f3f63a649c004e1100605
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
  VERSION_STRING="lxsession-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/lxsession-%version%.tar.gz"
  )
}
