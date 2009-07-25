#!/bin/bash

DISABLE_MULTILIB=1

VERSION="5.03"

DIR="file-${VERSION}"
TARBALL="file-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.astron.com/pub/file/${TARBALL}
)

MD5SUMS=(
d05f08a53e5c2f51f8ee6a4758c0cc53
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ./configure --prefix=/RBS-Cross-Tools || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

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
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.astron.com/pub/file/'
  VERSION_STRING='file-%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.astron.com/pub/file/file-%version%.tar.gz'
  )
}
