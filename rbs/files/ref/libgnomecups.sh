#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.3"

DIR="libgnomecups-${VERSION}"
TARBALL="libgnomecups-${VERSION}.tar.bz2"

DEPENDS=(
  cups
  glib
)

SRC1=(
  $(gnome_mirrors libgnomecups)
)

MD5SUMS=(
dc4920c15c9f886f73ea74fbff0ae48b
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomecups/%minor_version%/'
  VERSION_STRING='libgnomecups-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgnomecups/%minor_version%/libgnomecups-%version%.tar.bz2'
  )
}
