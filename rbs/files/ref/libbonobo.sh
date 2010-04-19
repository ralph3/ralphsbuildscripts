#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="libbonobo-${VERSION}"
TARBALL="libbonobo-${VERSION}.tar.bz2"

DEPENDS=(
  popt
)

SRC1=(
  $(gnome_mirrors libbonobo)
)

MD5SUMS=(
b217cef6a187505290c66c5bf8225d38
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/bonobo \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libbonobo/%minor_version%/'
  VERSION_STRING='libbonobo-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libbonobo/%minor_version%/libbonobo-%version%.tar.bz2'
  )
}
