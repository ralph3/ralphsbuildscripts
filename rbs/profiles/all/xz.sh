#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.999.8beta"
SYS_VERSION="4.999.8beta-3"

DIR="xz-${VERSION}"
TARBALL="xz-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://tukaani.org/xz/${TARBALL}
)

MD5SUMS=(
f00967331a487e88d51207fe17c56f52
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools \
    --libdir=/RBS-Tools/$LIBSDIR || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/bin || return 1
  mv -v $TMPROOT/usr/bin/{xz,lzma,lzcat,unlzma,unxz,xzcat} $TMPROOT/bin/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://tukaani.org/xz/'
  VERSION_STRING='xz-%version%.tar.gz'
  MIRRORS=(
    'http://tukaani.org/xz/xz-%version%.tar.gz'
  )
}
