#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.6.19"

DIR="libexif-${VERSION}"
TARBALL="libexif-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/libexif/${TARBALL}
)

MD5SUMS=(
56144a030a4c875c600b1ccf713f69f7
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
