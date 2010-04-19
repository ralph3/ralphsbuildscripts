#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.18.5"

DIR="libgnomeprint-${VERSION}"
TARBALL="libgnomeprint-${VERSION}.tar.bz2"

DEPENDS=(
  libgnomecups
  popt
)

SRC1=(
  $(gnome_mirrors libgnomeprint)
)

MD5SUMS=(
c325baf4487335259e050619185787b1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomeprint/%minor_version%/'
  VERSION_STRING='libgnomeprint-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgnomeprint/%minor_version%/libgnomeprint-%version%.tar.bz2'
  )
}
