#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="pyorbit-${VERSION}"
TARBALL="pyorbit-${VERSION}.tar.bz2"

DEPENDS=(
  orbit2
  pygtk
)

SRC1=(
  $(gnome_mirrors pyorbit)
)

MD5SUMS=(
574593815e75ee6e98062c75d6d1581f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" LIBS="/$LIBSDIR/libz.so.1" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/pyorbit/%minor_version%/'
  VERSION_STRING='pyorbit-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/pyorbit/%minor_version%/pyorbit-%version%.tar.bz2"
  )
}
