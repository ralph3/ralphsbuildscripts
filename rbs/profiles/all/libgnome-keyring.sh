#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.0"

DIR="libgnome-keyring-${VERSION}"
TARBALL="libgnome-keyring-${VERSION}.tar.bz2"

DEPENDS=(
  libgcrypt
)

SRC1=(
  $(gnome_mirrors libgnome-keyring)
)

MD5SUMS=(
d267de8d0bc3d2c7b0f23135b98ee8c9
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/libgnome-keyring \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/%minor_version%/'
  VERSION_STRING='libgnome-keyring-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/%minor_version%/libgnome-keyring-%version%.tar.bz2'
  )
}
