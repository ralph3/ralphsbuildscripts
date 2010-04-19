#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.40.6"

DIR="intltool-${VERSION}"
TARBALL="intltool-${VERSION}.tar.bz2"

DEPENDS=(
  perl-xml-parser
)

SRC1=(
  $(gnome_mirrors intltool)
)

MD5SUMS=(
69bc0353323112f42ad4f9cf351bc3e5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/intltool/%minor_version%/'
  VERSION_STRING='intltool-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/intltool/%minor_version%/intltool-%version%.tar.bz2'
  )
}
