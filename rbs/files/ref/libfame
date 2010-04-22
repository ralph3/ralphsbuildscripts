#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.9.1"

DIR="libfame-${VERSION}"
TARBALL="libfame-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/fame/${TARBALL}
)

MD5SUMS=(
880085761e17a3b4fc41f4f6f198fd3b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch libfame-0.9.1-gcc34-1.patch \
    libfame-0.9.1-config_update-1.patch || return 1
  sed -i "s/\$CC -shared/& ${BUILD}/" ltconfig || return 1
  sed -i 's/$CC --version/$CC -dumpversion/' configure || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  set_multiarch $TMPROOT/usr/bin/libfame-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/fame/'
  VERSION_STRING='libfame-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/fame/libfame-%version%.tar.gz"
  )
}
