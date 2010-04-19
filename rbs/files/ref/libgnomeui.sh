#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="libgnomeui-${VERSION}"
TARBALL="libgnomeui-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-keyring
  libgnome
  libgnomecanvas
  libbonoboui
)

SRC1=(
  $(gnome_mirrors libgnomeui)
)

MD5SUMS=(
7d50e1fc4c1ee3c268b26e8dfe7e677b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/libgnomeui \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomeui/%minor_version%/'
  VERSION_STRING='libgnomeui-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgnomeui/%minor_version%/libgnomeui-%version%.tar.bz2'
  )
}
