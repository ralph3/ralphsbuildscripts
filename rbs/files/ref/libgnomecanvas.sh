#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.20.1.1"

DIR="libgnomecanvas-${VERSION}"
TARBALL="libgnomecanvas-${VERSION}.tar.bz2"

DEPENDS=(
  gail
  libart_lgpl
  libglade
  perl-xml-parser
)

SRC1=(
  $(gnome_mirrors libgnomecanvas)
)

MD5SUMS=(
948ed771d2957d24a0c9a414e9581055
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomecanvas/%minor_version%/'
  VERSION_STRING='libgnomecanvas-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libgnomecanvas/%minor_version%/libgnomecanvas-%version%.tar.bz2"
  )
}
