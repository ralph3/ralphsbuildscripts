#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.12.4"

DIR="quickfix"
TARBALL="quickfix-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://prdownloads.sourceforge.net/quickfix/${TARBALL}
)

MD5SUMS=(
359fd12942d7e876275a116787fdd284
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.quickfixengine.org/download.html'
  VERSION_STRING='quickfix-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/quickfix/quickfix-%version%.tar.gz'
  )
}
