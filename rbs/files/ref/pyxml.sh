#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.4"

DIR="PyXML-${VERSION}"
TARBALL="PyXML-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://prdownloads.sourceforge.net/pyxml/${TARBALL}
)

MD5SUMS=(
1f7655050cebbb664db976405fdba209
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
  ADDRESS='http://prdownloads.sourceforge.net/pyxml/'
  VERSION_STRING='PyXML-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/PyXML/PyXML-%version%.tar.gz'
  )
}
