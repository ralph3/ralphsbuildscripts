#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.14"

TARBALL="a2ps-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
 $(gnu_mirrors a2ps)
)

MD5SUMS=(
781ac3d9b213fa3e1ed0d79f986dc8c7
)

build(){
  DIR=$(get_tarball_dir $DOWNLOADDIR/$TARBALL)
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i '/char \*malloc ();/d' lib/path-concat.c || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/*.el || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/a2ps/'
  VERSION_STRING='a2ps-%version%.tar.gz'
  MIRRORS=(
    "http://ftp.gnu.org/gnu/a2ps/a2ps-%version%.tar.gz"
  )
}
