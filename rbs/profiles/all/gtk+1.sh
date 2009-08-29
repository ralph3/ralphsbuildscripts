#!/bin/bash

VERSION="1.2.10"

DIR="gtk+-1.2.10"
TARBALL="gtk+-1.2.10.tar.gz"

DEPENDS=(
  glib1
)

SRC1=(
ftp://ftp.gtk.org/pub/gtk/v1.2/gtk+-1.2.10.tar.gz
)

MD5SUMS=(
4d5cb2fc7fb7830e4af9747a36bfce20
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch gtk+-1.2.10-fixes-1.patch \
    gtk+-1.2.10-config_update-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
