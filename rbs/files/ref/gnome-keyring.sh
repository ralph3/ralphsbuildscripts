#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.0"
SYS_VERSION="2.30.0-1"

DIR="gnome-keyring-${VERSION}"
TARBALL="gnome-keyring-${VERSION}.tar.bz2"

DEPENDS=(
  libtasn1
)

SRC1=(
  $(gnome_mirrors gnome-keyring)
)

MD5SUMS=(
293f3dfed78b5c3d34d72d1561f5aa32
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-keyring \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-keyring/%minor_version%/'
  VERSION_STRING='gnome-keyring-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-keyring/%minor_version%/gnome-keyring-%version%.tar.bz2'
  )
}
