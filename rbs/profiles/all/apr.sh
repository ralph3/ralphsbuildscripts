#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.7"
SYS_VERSION="1.3.7-1"

DIR="apr-${VERSION}"
TARBALL="apr-${VERSION}.tar.bz2"

DEPENDS=(
  e2fsprogs
)

SRC1=(
http://apache.cs.utah.edu/apr/${TARBALL}
)

MD5SUMS=(
1414f695a236a2bf8e470ca624d6a2e8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR \
    --with-installbuilddir=/usr/$LIBSDIR/apr-1 || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  find $TMPROOT -name 'libtool' -exec sed -i 's%\/RBS-Tools%%g' {} \;
  set_multiarch $TMPROOT/usr/bin/apr-1-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://apr.apache.org/download.cgi'
  VERSION_STRING='apr-%version%.tar.bz2'
  MIRRORS=(
    'http://apache.cs.utah.edu/apr/apr-%version%.tar.bz2'
  )
}
