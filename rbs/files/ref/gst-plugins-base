#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.22"

DIR="gst-plugins-base-${VERSION}"
TARBALL="gst-plugins-base-${VERSION}.tar.bz2"

DEPENDS=(
  alsa-lib
  gstreamer
  liboil
  libvorbis
)

SRC1=(
http://gstreamer.freedesktop.org/src/gst-plugins-base/${TARBALL}
)

MD5SUMS=(
5d0f1e07f8f6db564971b50f75261e8a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gstreamer.freedesktop.org/src/gst-plugins-base/'
  VERSION_STRING='gst-plugins-base-%version%.tar.bz2'
  MIRRORS=(
    "http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-%version%.tar.bz2"
  )
}
