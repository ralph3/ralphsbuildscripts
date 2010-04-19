#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.10"
SYS_VERSION="1.0.10-1"

DIR="libmng-${VERSION}"
TARBALL="libmng-${VERSION}.tar.gz"

DEPENDS=(
  lcms
)

SRC1=(
http://prdownloads.sourceforge.net/libmng/${TARBALL}
)

MD5SUMS=(
a464ae7d679781beebdf7440d144b7bd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed "/OBJSDLL/s/\.0/.o/" makefiles/makefile.linux > Makefile
  make CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS" prefix=/usr \
    LIBPATH=/usr/$LIBSDIR ZLIBLIB=/usr/$LIBSDIR JPEGLIB=/usr/$LIBSDIR \
    LCMSLIB=/usr/$LIBSDIR || return 1
  mkdir -p $TMPROOT/usr/{include,${LIBSDIR},share/man/man{3,5}} || return 1
  make prefix=$TMPROOT/usr LIBPATH=$TMPROOT/usr/$LIBSDIR install || return 1
  install -v -m644 doc/man/*.3 $TMPROOT/usr/share/man/man3 || return 1
  install -v -m644 doc/man/*.5 $TMPROOT/usr/share/man/man5 || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/libmng-${VERSION} || return 1
  install -v -m644 doc/*.{png,txt} \
    $TMPROOT/usr/share/doc/libmng-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=5635&package_id=5691'
  VERSION_STRING='libmng-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/libmng/libmng-%version%.tar.gz'
  )
}
