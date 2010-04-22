#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.15.1b"

DIR="libid3tag-${VERSION}"
TARBALL="libid3tag-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/mad/${TARBALL}
)

MD5SUMS=(
e5808ad997ba32c498803822078748c3
)

build(){
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
  ADDRESS='http://prdownloads.sourceforge.net/mad/'
  VERSION_STRING='libid3tag-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/mad/libid3tag-%version%.tar.gz"
  )
}
