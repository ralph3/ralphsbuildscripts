#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.1.7"

DIR="gawk-${VERSION}"
TARBALL="gawk-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/gawk/${TARBALL}
)

MD5SUMS=(
674cc5875714315c490b26293d36dfcf
)

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=$TCDIR \
    --libexecdir=$TCDIR/$LIBSDIR --disable-libsigsegv || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --disable-libsigsegv \
    --libexecdir=/usr/$LIBSDIR || return 1
  make || return 1
  make LN="ln -sn" install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gawk/'
  VERSION_STRING='gawk-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gawk/gawk-%version%.tar.bz2'
  )
}
