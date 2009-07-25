#!/bin/bash

VERSION="0.82"
SYS_VERSION="0.82-1"

DIR="dbus-glib-${VERSION}"
TARBALL="dbus-glib-${VERSION}.tar.gz"

DEPENDS=(
  dbus
  glib
)

SRC1=(
http://dbus.freedesktop.org/releases/dbus-glib/${TARBALL}
)

MD5SUMS=(
aa2a4517de0e9144be3bce2cf8cdd924
)

build(){
  local KILLIT
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  KILLIT=
  if [ "$(cat /var/run/dbus/pid 2>/dev/null)" == "" ]; then
    /usr/bin/dbus-daemon --config-file=/etc/dbus-1/system.conf || return 1
    KILLIT=1
  fi
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc \
    --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  if [ -n "$KILLIT" ]; then
    kill $(cat /var/run/dbus/pid) || return 1
    rm -f /var/run/dbus/pid /var/run/dbus/system_bus_socket || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://dbus.freedesktop.org/releases/dbus-glib/'
  VERSION_STRING='dbus-glib-%version%.tar.gz'
  MIRRORS=(
    'http://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-%version%.tar.gz'
  )
}
