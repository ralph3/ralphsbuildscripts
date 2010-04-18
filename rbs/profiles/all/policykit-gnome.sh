#!/bin/bash

VERSION="0.9.2"

DIR="PolicyKit-gnome-${VERSION}"
TARBALL="PolicyKit-gnome-${VERSION}.tar.bz2"

DEPENDS=(
  policykit
  gnome-doc-utils
)

SRC1=(
  http://hal.freedesktop.org/releases/$TARBALL
)

MD5SUMS=(
fc478b168d0c926a9766b0b415ff4bbf
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var --disable-gtk-doc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://hal.freedesktop.org/releases/'
  VERSION_STRING='PolicyKit-gnome-%version%.tar.bz2'
  MIRRORS=(
    'http://hal.freedesktop.org/releases/PolicyKit-gnome-%version%.tar.bz2'
  )
}
