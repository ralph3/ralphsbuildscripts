#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.6.18"

DIR="libexif-${VERSION}"
TARBALL="libexif-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/libexif/${TARBALL}
)

MD5SUMS=(
67dfabfaf398d370ed92203ca7c36a0a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's% install-data-local % %g' doc/Makefile.in || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=12272&package_id=38136'
  VERSION_STRING='libexif-%version%.tar.bz2'
  MINOR_VERSION="0.5"
  MIRRORS=(
    'http://prdownloads.sourceforge.net/libexif/libexif-%version%.tar.bz2'
  )
}
