#!/bin/bash

DISABLE_MULTILIB=1

VERSION="398-2"

DIR="lame-${VERSION}"
TARBALL="lame-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/lame/${TARBALL}
)

MD5SUMS=(
719dae0ee675d0c16e0e89952930ed35
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-mp3rtp || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=290&package_id=309'
  VERSION_STRING='lame-%version%.tar.gz'
  VERSION_FILTERS="[a-z]"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lame/lame-%version%.tar.gz"
  )
}
