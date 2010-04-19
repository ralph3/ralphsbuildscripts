#!/bin/bash

DISABLE_MULTILIB=1

VERSION="5.08"

DIR="xscreensaver-${VERSION}"
TARBALL="xscreensaver-${VERSION}.tar.gz"

DEPENDS=(
  bc
)

SRC1=(
http://www.jwz.org/xscreensaver/${TARBALL}
)

MD5SUMS=(
79dea708c915341f205e00318a699be9
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install install_prefix=$TMPROOT || return 1
  rm $TMPROOT/usr/$LIBSDIR/xscreensaver/providence || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.jwz.org/xscreensaver/download.html'
  VERSION_STRING='xscreensaver-%version%.tar.gz'
  VERSION_FILTERS='b'
  MIRRORS=(
    'http://www.jwz.org/xscreensaver/xscreensaver-%version%.tar.gz'
  )
}
