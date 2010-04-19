#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.18.3"

DIR="libgnomeprintui-${VERSION}"
TARBALL="libgnomeprintui-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-icon-theme
  libgnomecanvas
  libgnomeprint
)

SRC1=(
  $(gnome_mirrors libgnomeprintui)
)

MD5SUMS=(
f2c5796f15d6b6701bfa224d856098ce
)

DEPENDS="gnome-icon-theme"

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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomeprintui/%minor_version%/'
  VERSION_STRING='libgnomeprintui-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgnomeprintui/%minor_version%/libgnomeprintui-%version%.tar.bz2'
  )
}
