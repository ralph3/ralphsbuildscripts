#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.6.19"

DIR="db-${VERSION}"
TARBALL="db-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://download.oracle.com/berkeley-db/${TARBALL}
)

MD5SUMS=(
89c7390ff120d5ebf3eccc5f97249e79
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR/build_unix || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ../dist/configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-compat185 --enable-cxx \
    --enable-rpc || return 1
  make || return 1
  make docdir=$TMPROOT/usr/share/doc/db-${VERSION} install \
    prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  chown root:root $TMPROOT/usr/bin/db_* $TMPROOT/usr/$LIBSDIR/libdb* \
    $TMPROOT/usr/include/db* || return 1
  chown -R root:root $TMPROOT/usr/share/doc/db-${VERSION} || return 1
  cd ../../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.oracle.com/technology/software/products/berkeley-db/index.html'
  VERSION_STRING='DB %version% .tar.gz'
  MIRRORS=(
    'http://download.oracle.com/berkeley-db/db-%version%.tar.gz'
  )
}

