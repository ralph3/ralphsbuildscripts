#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.9.15"

DIR="imlib-${VERSION}"
TARBALL="imlib-${VERSION}.tar.bz2"

DEPENDS=(
  giflib
  libjpeg
  libtiff
)

SRC1=(
  $(gnome_mirrors imlib)
)

MD5SUMS=(
7db987e6c52e4daf70d7d0f471238eae
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc/imlib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/imlib-config || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/imlib-${VERSION} || return 1
  install -v -m644 doc/{index.html,*.gif} \
    $TMPROOT/usr/share/doc/imlib-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/imlib/%minor_version%/'
  VERSION_STRING='imlib-%version%.tar.bz2'
  ##ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/imlib/%minor_version%/imlib-%version%.tar.bz2"
  )
}
