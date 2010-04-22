#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.10"

DIR="gst-plugins-bad-${VERSION}"
TARBALL="gst-plugins-bad-${VERSION}.tar.bz2"

DEPENDS=(
  faac
  faad
  gst-plugins-base
  libmms
  sdl
  xvidcore
)

SRC1=(
http://gstreamer.freedesktop.org/src/gst-plugins-bad/${TARBALL}
)

MD5SUMS=(
cd13758801f6054006ff1a4755e72484
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --disable-neon || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gstreamer.freedesktop.org/src/gst-plugins-bad/'
  VERSION_STRING='gst-plugins-bad-%version%.tar.bz2'
  MIRRORS=(
    "http://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-%version%.tar.bz2"
  )
}
