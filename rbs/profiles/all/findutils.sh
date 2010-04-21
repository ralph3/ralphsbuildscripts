#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.4.2"

DIR="findutils-${VERSION}"
TARBALL="findutils-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/findutils/${TARBALL}
)

MD5SUMS=(
351cc4adb07d54877fa15f75fb77d39f
)

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo "gl_cv_func_wcwidth_works=yes" > config.cache
  echo "ac_cv_func_fnmatch_gnu=yes" >> config.cache
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=$TCDIR \
    --cache-file=config.cache || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr \
    --libexecdir=/usr/$LIBSDIR/locate \
    --localstatedir=/var/lib/locate || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/findutils/'
  VERSION_STRING='findutils-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/findutils/findutils-%version%.tar.gz'
  )
}
