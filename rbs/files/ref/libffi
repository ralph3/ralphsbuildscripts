#!/bin/bash

VERSION="3.0.9"

DIR="libffi-${VERSION}"
TARBALL="libffi-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://sources.redhat.com/pub/libffi/$TARBALL
)

MD5SUMS=(
1f300a7a7f975d4046f51c3022fa5ff1
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
  ADDRESS='ftp://sources.redhat.com/pub/libffi/'
  VERSION_STRING='libffi-%version%.tar.gz'
  VERSION_FILTERS='rc'
  MIRRORS=(
    "ftp://sources.redhat.com/pub/libffi/libffi-%version%.tar.gz"
  )
}
