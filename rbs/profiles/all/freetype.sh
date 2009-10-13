#!/bin/bash

VERSION="2.3.11"

DIR="freetype-${VERSION}"
TARBALL="freetype-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/freetype/${TARBALL}
)

MD5SUMS=(
519c7cbf5cbd72ffa822c66844d3114c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/freetype-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=3157&package_id=3121'
  VERSION_STRING='freetype-%version%.tar.bz2'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/freetype/freetype-%version%.tar.bz2'
  )
}
