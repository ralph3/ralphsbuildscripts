#!/bin/bash

VERSION="0.9"
SYS_VERSION="0.9-2"

DIR="PolicyKit-${VERSION}"
TARBALL="PolicyKit-${VERSION}.tar.gz"

DEPENDS=(
  dbus-glib
  intltool
  linux-pam
)

SRC1=(
  http://hal.freedesktop.org/releases/$TARBALL
)

MD5SUMS=(
802fd13ae41f73d79359e5ecb0a98716
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
  VERSION_STRING='PolicyKit-%version%.tar.gz'
  MIRRORS=(
    'http://hal.freedesktop.org/releases/PolicyKit-%version%.tar.gz'
  )
}
