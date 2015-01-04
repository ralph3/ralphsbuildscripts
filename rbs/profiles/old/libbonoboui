#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="libbonoboui-${VERSION}"
TARBALL="libbonoboui-${VERSION}.tar.bz2"

DEPENDS=(
  gail
)

SRC1=(
  $(gnome_mirrors libbonoboui)
)

MD5SUMS=(
2076638f9aa9565c12b2bc264ecc4f18
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -f $TMPROOT/usr/share/applications/bonobo-browser.desktop
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libbonoboui/%minor_version%/'
  VERSION_STRING='libbonoboui-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libbonoboui/%minor_version%/libbonoboui-%version%.tar.bz2'
  )
}
