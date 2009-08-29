#!/bin/bash

VERSION="1.2.10"

DIR="glib-1.2.10"
TARBALL="glib-1.2.10.tar.gz"

DEPENDS=(
  libx11
)

SRC1=(
ftp://ftp.gtk.org/pub/gtk/v1.2/glib-1.2.10.tar.gz
)

MD5SUMS=(
6fe30dad87c77b91b632def29dd69ef9
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch glib-1.2.10-fixes-1.patch \
    glib-1.2.10-config_update-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
