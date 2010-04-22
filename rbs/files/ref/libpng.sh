#!/bin/bash

VERSION="1.2.39"

DIR="libpng-${VERSION}"
TARBALL="libpng-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/libpng/${TARBALL}
)

MD5SUMS=(
4d48ecff6fc7ab12e97b07d0f65ec2f0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/libpng{,12}-config || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/libpng-${VERSION} || return 1
  install -v -m644 README \
    $TMPROOT/usr/share/doc/libpng-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=5624&package_id=5683'
  VERSION_STRING='libpng-%version%.tar.bz2'
  VERSION_FILTERS='rc beta no-config'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/libpng/libpng-%version%.tar.bz2'
  )
}