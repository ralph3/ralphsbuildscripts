#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6"

DIR="xkeyboard-config-${VERSION}"
TARBALL="xkeyboard-config-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xlibs.freedesktop.org/xkbdesc/${TARBALL}
)

MD5SUMS=(
5ae575a9073af12cd71773e065b38b3a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var \
    --with-xkb_base=/usr/share/X11/xkb \
    --with-xkb-rules-symlink=xorg || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xlibs.freedesktop.org/xkbdesc/'
  VERSION_STRING='xkeyboard-config-%version%.tar.bz2'
  MIRRORS=(
    'http://xlibs.freedesktop.org/xkbdesc/xkeyboard-config-%version%.tar.bz2'
  )
}
