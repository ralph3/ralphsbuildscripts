#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.22.3"

DIR="gail-${VERSION}"
TARBALL="gail-${VERSION}.tar.bz2"

DEPENDS=(
  atk
  gtk+
  libgnomecanvas
)

SRC1=(
  $(gnome_mirrors gail)
)

MD5SUMS=(
1b0d2b3d5f89fb620ce6122e52578b41
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gail/%minor_version%/'
  VERSION_STRING='gail-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gail/%minor_version%/gail-%version%.tar.bz2'
  )
}
