#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.17"

DIR="gettext-${VERSION}"
TARBALL="gettext-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/gettext/${TARBALL}
)

MD5SUMS=(
58a2bc6d39c0ba57823034d55d65d606
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo "gl_cv_func_wcwidth_works=yes" > config.cache || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools \
    --libdir=/RBS-Tools/$LIBSDIR --cache-file=config.cache || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gettext/'
  VERSION_STRING='gettext-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gettext/gettext-%version%.tar.gz'
  )
}