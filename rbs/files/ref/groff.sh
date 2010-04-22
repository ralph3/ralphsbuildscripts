#!/bin/bash

DISABLE_MULTILIB=1 #has just a shell script and some crap in LIBDIR

VERSION="1.20.1"

DIR="groff-${VERSION}"
TARBALL="groff-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/groff/${TARBALL}
)

MD5SUMS=(
48fa768dd6fdeb7968041dd5ae8e2b02
)

cross_tools_build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  PAGE=[paper_size] ./configure --prefix=$ROOT/cross-tools \
    --without-x || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" PAGE=letter ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  mkdir -p $TMPROOT/usr
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  ln -sfn soelim $TMPROOT/usr/bin/zsoelim || return 1
  ln -sfn eqn $TMPROOT/usr/bin/geqn || return 1
  ln -sfn tbl $TMPROOT/usr/bin/gtbl || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/groff/'
  VERSION_STRING='groff-%version%.tar.gz'
  VERSION_FILTERS='-'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/groff/groff-%version%.tar.gz'
  )
}