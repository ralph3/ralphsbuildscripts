#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.22"

DIR="gstreamer-${VERSION}"
TARBALL="gstreamer-${VERSION}.tar.bz2"

DEPENDS=(
  glib
  libxml2
)

SRC1=(
http://gstreamer.freedesktop.org/src/gstreamer/${TARBALL}
)

MD5SUMS=(
35dd8598837af4074753afe5b59e8ef2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc \
    --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gstreamer install || return 1
}

pre_remove(){
  gnome_script gstreamer remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://gstreamer.freedesktop.org/src/gstreamer/'
  VERSION_STRING='gstreamer-%version%.tar.bz2'
  ONLY_EVEN_MINORS=0
  MIRRORS=(
    'http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-%version%.tar.bz2'
  )
}
