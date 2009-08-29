#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.15"

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
d90a7fe883f29caca149f04f31e2f0f9
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
