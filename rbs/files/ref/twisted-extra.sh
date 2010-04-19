#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.0"

DIR="Twisted-${VERSION}"
TARBALL="Twisted-${VERSION}.tar.bz2"

DEPENDS=(
  twisted-core
)

SRC1=(
http://tmrc.mit.edu/mirror/twisted/Twisted/2.4/${TARBALL}
)

MD5SUMS=(
42eb0c8fd0f8707a39fff1dd6adab27d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" python setup.py install \
    --root $TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://tmrc.mit.edu/mirror/twisted/Twisted/%minor_version%/'
  VERSION_STRING='Twisted-%version%.tar.bz2'
  MIRRORS=(
    'http://tmrc.mit.edu/mirror/twisted/Twisted/%minor_version%/Twisted-%version%.tar.bz2'
  )
}
