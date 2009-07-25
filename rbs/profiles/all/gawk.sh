#!/bin/bash

DISABLE_MULTILIB=1

#3.1.7 has cross compile bug when building it for toolchain

VERSION="3.1.6"

DIR="gawk-${VERSION}"
TARBALL="gawk-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/gawk/${TARBALL}
)

MD5SUMS=(
c9926c0bc8c177cb9579708ce67f0d75
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools \
    --libexecdir=/RBS-Tools/$LIBSDIR || return 1
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
    --libexecdir=/usr/$LIBSDIR || return 1
  echo '#define HAVE_LANGINFO_CODESET 1' >> config.h
  echo '#define HAVE_LC_MESSAGES 1' >> config.h
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
