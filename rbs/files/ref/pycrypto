#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.1"

DIR="pycrypto-${VERSION}"
TARBALL="pycrypto-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://www.amk.ca/files/python/crypto/${TARBALL}
)

MD5SUMS=(
4d5674f3898a573691ffb335e8d749cd
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
  ADDRESS='http://www.amk.ca/files/python/crypto/'
  VERSION_STRING='pycrypto-%version%.tar.gz'
  MIRRORS=(
    'http://www.amk.ca/files/python/crypto/pycrypto-%version%.tar.gz'
  )
}
