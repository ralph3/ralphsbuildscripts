#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.86"

DIR="sysvinit-${VERSION}"
TARBALL="sysvinit-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/${TARBALL}
)

MD5SUMS=(
7d5d61c026122ab791ac04c8a84db967
)

MyBuild(){
  
  MYDEST=$1
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's@Sending processes@& started by init@g' \
    src/init.c || return 1
  sed -i -e 's@/dev/initctl@$(ROOT)&@g' \
    -e 's@\(mknod \)-m \([0-9]* \)\(.* \)p@\1\3p; chmod \2\3@g' \
    -e '/^ifeq/s/$(ROOT)//' \
    -e 's@/usr/lib@$(ROOT)&@' \
    src/Makefile || return 1
  make CFLAGS="-Wall -D_GNU_SOURCE $CFLAGS" CC="$CC $BUILD" \
    CXX="$CXX $BUILD" ROOT=/ -C src clobber || return 1
  make CFLAGS="-Wall -D_GNU_SOURCE $CFLAGS" CC="$CC $BUILD" \
    CXX="$CXX $BUILD" LDFLAGS="/$LIBSDIR/libcrypt.so.1" ROOT=/ -C src || return 1
  mkdir -p $MYDEST/{{s,}bin,dev,usr/{bin,include,share/man/man{1,5,8}}} || return 1
  make -C src install ROOT=$MYDEST || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

Tools_Build(){
  MyBuild $ROOT || return 1
}

build(){
  MyBuild $TMPROOT || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/'
  VERSION_STRING='sysvinit-%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/sysvinit-%version%.tar.gz'
  )
}
