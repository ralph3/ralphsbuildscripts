#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.7"

DIR="Imaging-${VERSION}"
TARBALL="Imaging-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://effbot.org/downloads/${TARBALL}
)

MD5SUMS=(
fc14a54e1ce02a0225be8854bfba478e
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
  ADDRESS='http://www.pythonware.com/products/pil/'
  VERSION_STRING='Imaging-%version%.tar.gz'
  MIRRORS=(
    'http://effbot.org/downloads/Imaging-%version%.tar.gz'
  )
}
