#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.6"

DIR="gst-ffmpeg-${VERSION}"
TARBALL="gst-ffmpeg-${VERSION}.tar.bz2"

DEPENDS=(
  ffmpeg
  gstreamer
)

SRC1=(
http://gstreamer.freedesktop.org/src/gst-ffmpeg/${TARBALL}
)

MD5SUMS=(
063a8184916426d6b79a97dea9636a78
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc \
    --enable-cross-compile || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gstreamer.freedesktop.org/src/gst-ffmpeg/'
  VERSION_STRING='gst-ffmpeg-%version%.tar.bz2'
  MIRRORS=(
    "http://gstreamer.freedesktop.org/src/gst-ffmpeg/gst-ffmpeg-%version%.tar.bz2"
  )
}

