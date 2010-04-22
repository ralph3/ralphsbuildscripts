#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.2"

DIR="gtksourceview-${VERSION}"
TARBALL="gtksourceview-${VERSION}.tar.bz2"

DEPENDS=(
  libgnomeprint
  pygtk
)

SRC1=(
  $(gnome_mirrors gtksourceview)
)

MD5SUMS=(
aece5dcb1e2e7ca1855f95eb48f30443
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/%minor_version%/'
  VERSION_STRING='gtksourceview-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/%minor_version%/gtksourceview-%version%.tar.bz2'
  )
}
