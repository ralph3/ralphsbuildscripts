#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.0"

DIR="libvorbis-${VERSION}"
TARBALL="libvorbis-${VERSION}.tar.gz"

DEPENDS=(
  libogg
)

SRC1=(
http://downloads.xiph.org/releases/vorbis/${TARBALL}
)

MD5SUMS=(
478646358c49f34aedcce58948793619
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
  ADDRESS='http://downloads.xiph.org/releases/vorbis/'
  VERSION_STRING='libvorbis-%version%.tar.gz'
  VERSION_FILTERS='beta rc'
  MIRRORS=(
    'http://downloads.xiph.org/releases/vorbis/libvorbis-%version%.tar.gz'
  )
}
