#!/bin/bash

VERSION="0.83.1"

DIR="dbus-python-${VERSION}"
TARBALL="dbus-python-${VERSION}.tar.gz"

DEPENDS=(
  dbus
  python
)

SRC1=(
http://dbus.freedesktop.org/releases/dbus-python/${TARBALL}
)

MD5SUMS=(
5fdf3970aa0c00020289de7ba8f3be18
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc \
    --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://dbus.freedesktop.org/releases/dbus-python/'
  VERSION_STRING='dbus-python-%version%.tar.gz'
  MIRRORS=(
    'http://dbus.freedesktop.org/releases/dbus-python/dbus-python-%version%.tar.gz'
  )
}
