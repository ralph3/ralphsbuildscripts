#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.14.1"

DIR="libggz-${VERSION}"
TARBALL="libggz-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.belnet.be/packages/ggzgamingzone/ggz/$VERSION/${TARBALL}
)

MD5SUMS=(
603739504648833779aa13b0327a1c3d
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
  ADDRESS='http://ftp.belnet.be/packages/ggzgamingzone/ggz/%version%/'
  VERSION_STRING='libggz-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.belnet.be/packages/ggzgamingzone/ggz/%version%/libggz-%version%.tar.gz'
  )
}
