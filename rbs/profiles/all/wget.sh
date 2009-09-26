#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.12"

DIR="wget-${VERSION}"
TARBALL="wget-${VERSION}.tar.gz"

DEPENDS=(
  openssl
)

SRC1=(
http://ftp.gnu.org/gnu/wget/${TARBALL}
)

MD5SUMS=(
141461b9c04e454dc8933c9d1f2abf83
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mv $TMPROOT/etc/wgetrc $TMPROOT/etc/wgetrc.tmpnew || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/wget/'
  VERSION_STRING='wget-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/wget/wget-%version%.tar.gz'
  )
}
