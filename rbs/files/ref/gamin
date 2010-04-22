#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.10"

DIR="gamin-${VERSION}"
TARBALL="gamin-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.gnome.org/~veillard/gamin/sources/${TARBALL}
)

MD5SUMS=(
b4ec549e57da470c04edd5ec2876a028
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc \
    --libexecdir=/usr/sbin || return 1
  find -name 'Makefile' -exec sed -i 's%-Wall %& -D_GNU_SOURCE%g' {} \;
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.gnome.org/~veillard/gamin/sources/'
  VERSION_STRING='gamin-%version%.tar.gz'
  MIRRORS=(
    'http://www.gnome.org/~veillard/gamin/sources/gamin-%version%.tar.gz'
  )
}
