#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6.8"

DIR="gc${VERSION}"
TARBALL="gc${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${TARBALL}
)

MD5SUMS=(
418d38bd9c66398386a372ec0435250e
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
  ADDRESS='http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/'
  VERSION_STRING='gc%version%.tar.gz'
  VERSION_FILTERS='alpha'
  MIRRORS=(
    'http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc%version%.tar.gz'
  )
}
