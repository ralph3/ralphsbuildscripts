#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.11"

DIR="gst-plugins-good-${VERSION}"
TARBALL="gst-plugins-good-${VERSION}.tar.bz2"

DEPENDS=(
  gst-plugins-base
  speex
)

SRC1=(
http://gstreamer.freedesktop.org/src/gst-plugins-good/${TARBALL}
)

MD5SUMS=(
79b086c2dc0e07ae0c8ddc91512bab3a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  aclocal || return 1
  libtoolize --force || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gstreamer.freedesktop.org/src/gst-plugins-good/'
  VERSION_STRING='gst-plugins-good-%version%.tar.bz2'
  MIRRORS=(
    "http://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-%version%.tar.bz2"
  )
}
