#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.2.3"


DIR="gnomesword-${VERSION}"
TARBALL="gnomesword-${VERSION}.tar.gz"

DEPENDS=(
  gtkhtml38
  sword
  sword-kjv
)

SRC1=(
  http://prdownloads.sourceforge.net/gnomesword/$TARBALL
)

MD5SUMS=(
b8b331e0b6fbb1a53c6a778a5fd9298f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/gnomesword/'
  VERSION_STRING='gnomesword-%version%.tar.gz'
  #ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gnomesword/gnomesword-%version%.tar.gz'
  )
}
