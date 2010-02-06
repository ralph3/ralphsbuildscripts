#!/bin/bash

VERSION="2.6.30"
SYS_VERSION="2.6.30-3"

DIR="libxml2-${VERSION}"
TARBALL="libxml2-${VERSION}.tar.bz2"

DEPENDS=(
  python
  readline
)

SRC1=(
http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/${TARBALL}
)

MD5SUMS=(
cbc6d381daaa836b90a7ab449c1bc1ae
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-history || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/xml2-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libxml2/%minor_version%/'
  VERSION_STRING='libxml2-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libxml2/%minor_version%/libxml2-%version%.tar.bz2'
  )
}
