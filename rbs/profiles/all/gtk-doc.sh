#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.10"

DIR="gtk-doc-${VERSION}"
TARBALL="gtk-doc-${VERSION}.tar.bz2"

DEPENDS=(
  docbook-xml
  docbook-xsl
  openjade
)

SRC1=(
  $(gnome_mirrors gtk-doc)
)

MD5SUMS=(
cbd4be396b0cf8b8ce1fc9b927cdf451
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtk-doc/%minor_version%/'
  VERSION_STRING='gtk-doc-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtk-doc/%minor_version%/gtk-doc-%version%.tar.bz2'
  )
}
