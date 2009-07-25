#!/bin/bash

DISABLE_MULTILIB=1

VERSION="16.0"

DIR="hwinfo-${VERSION}"
TARBALL="hwinfo_${VERSION}.orig.tar.gz"

DEPENDS=(
  hal
)

SRC1=(
http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/${TARBALL}
)

MD5SUMS=(
b7e5cae47a373b75abd5a4a5f7584b98
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  #
  # Fix Patch still works on 15.3
  #
    do_patch hwinfo-14.19-fix-1.patch hwinfo-15.3-linux-2.6.26x-1.patch || return 1
  
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install LIBDIR=/usr/$LIBSDIR DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/'
  VERSION_STRING='hwinfo_%version%.orig.tar.gz'
  MIRRORS=(
    'http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/hwinfo_%version%.orig.tar.gz'
  )
}
