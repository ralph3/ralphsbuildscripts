#!/bin/bash

DISABLE_MULTILIB=1

VERSION="552"


APPVERSION="$(echo $VERSION | cut -b1).$(echo $VERSION | cut -b2-)"
DIR="unzip-${APPVERSION}"
TARBALL="unzip${VERSION}.tar.gz"

DEPENDS=(
  make
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch unzip-5.52-fix_Makefile-1.patch unzip-5.52-fix_libz-1.patch \
    unzip-5.52-dont_make_noise-1.patch || return 1
  make -f unix/Makefile LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 \
    CC="$CC ${BUILD}" LD='$(CC)' CF="-O -Wall -I. -DUSE_UNSHRINK" \
    unzips || return 1
  make -f unix/Makefile prefix=$TMPROOT/usr \
    libdir=$TMPROOT/usr/$LIBSDIR install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
