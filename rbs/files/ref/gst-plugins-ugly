#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.10"

DIR="gst-plugins-ugly-${VERSION}"
TARBALL="gst-plugins-ugly-${VERSION}.tar.bz2"

DEPENDS=(
  gst-plugins-base
  lame
  libid3tag
  libmad
  mpeg2dec
)

SRC1=(
http://gstreamer.freedesktop.org/src/gst-plugins-ugly/${TARBALL}
)

MD5SUMS=(
031205d5599fce73fc36766f928b2515
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
  ADDRESS='http://gstreamer.freedesktop.org/src/gst-plugins-ugly/'
  VERSION_STRING='gst-plugins-ugly-%version%.tar.bz2'
  MIRRORS=(
    "http://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-%version%.tar.bz2"
  )
}
