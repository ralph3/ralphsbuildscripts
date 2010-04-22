#!/bin/bash

VERSION="0.96"

DIR="polkit-${VERSION}"
TARBALL="polkit-${VERSION}.tar.gz"

DEPENDS=(
  intltool
  linux-pam
  eggdbus
  gobject-introspection
)

SRC1=(
  http://hal.freedesktop.org/releases/$TARBALL
)

MD5SUMS=(
e0a06da501b04ed3bab986a9df5b5aa2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc \
    --localstatedir=/var --disable-man-pages || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://hal.freedesktop.org/releases/'
  VERSION_STRING='polkit-%version%.tar.gz'
  MIRRORS=(
    'http://hal.freedesktop.org/releases/polkit-%version%.tar.gz'
  )
}