#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.19"

DIR="pyxdg-${VERSION}"
TARBALL="pyxdg-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://people.freedesktop.org/~lanius/${TARBALL}
)

MD5SUMS=(
9f33542e846d0fc1e0bfa992a8555b0a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  python setup.py build || return 1
  python setup.py install --root $TMPROOT || return 1
  if [ ! -e "$TMPROOT/usr/$LIBSDIR" ]; then
    mv $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://people.freedesktop.org/~lanius/'
  VERSION_STRING='pyxdg-%version%.tar.gz'
  MIRRORS=(
    'http://people.freedesktop.org/~lanius/pyxdg-%version%.tar.gz'
  )
}
