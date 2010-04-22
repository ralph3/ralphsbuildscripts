#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.16"

DIR="gtkspell-${VERSION}"
TARBALL="gtkspell-${VERSION}.tar.gz"

DEPENDS=(
  enchant
  gtk+
)

SRC1=(
http://gtkspell.sourceforge.net/download/${TARBALL}
)

MD5SUMS=(
f75dcc9338f182c571b321d37c606a94
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gtkspell.sourceforge.net/'
  VERSION_STRING='gtkspell-%version%.tar.gz'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://gtkspell.sourceforge.net/download/gtkspell-%version%.tar.gz'
  )
}
