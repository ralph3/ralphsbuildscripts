#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.41"

DIR="esound-${VERSION}"
TARBALL="esound-${VERSION}.tar.bz2"

DEPENDS=(
  alsa-lib
  audiofile
)

SRC1=(
  $(gnome_mirrors esound)
)

MD5SUMS=(
8d9aad3d94d15e0d59ba9dc0ea990c6c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/esd-config || return 1
  mv $TMPROOT/etc/esd.conf $TMPROOT/etc/esd.conf.new || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/esound/%minor_version%/'
  VERSION_STRING='esound-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/esound/%minor_version%/esound-%version%.tar.bz2'
  )
}