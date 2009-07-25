#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.60"

DIR="shared-mime-info-${VERSION}"
TARBALL="shared-mime-info-${VERSION}.tar.bz2"

DEPENDS=(
  intltool
)

SRC1=(
http://freedesktop.org/~hadess/${TARBALL}
)

MD5SUMS=(
339b8c284a3b7c153adea985b419030e
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

post_install(){
  update-mime-database /usr/share/mime || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://freedesktop.org/~hadess/'
  VERSION_STRING='shared-mime-info-%version%.tar.bz2'
  MIRRORS=(
    'http://freedesktop.org/~hadess/shared-mime-info-%version%.tar.bz2'
  )
}
