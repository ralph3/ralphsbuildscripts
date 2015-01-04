#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.6.3"
SYS_VERSION="3.6.3-1"

DIR="sqlite-${VERSION}"
TARBALL="sqlite-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.sqlite.org/${TARBALL}
)

MD5SUMS=(
671d2715f33158abc47a7a2ddd6066c5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.sqlite.org/download.html'
  VERSION_STRING='sqlite-%version%.tar.gz'
  MIRRORS=(
    'http://www.sqlite.org/sqlite-%version%.tar.gz'
  )
}
