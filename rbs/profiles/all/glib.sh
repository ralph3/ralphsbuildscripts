#!/bin/bash

VERSION="2.20.5"

DIR="glib-${VERSION}"
TARBALL="glib-${VERSION}.tar.bz2"

DEPENDS=(
  pkg-config
)

SRC1=(
  $(gnome_mirrors glib)
)

MD5SUMS=(
4c178b91d82ef80a2da3c26b772569c0
)

build(){
  #local CONF
  #CONF=
  #[ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ] && {
  #  CONF="--host=$BUILDTARGET"
  #}
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDTARGET --host=$BUILDTARGET --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/glib/%minor_version%/'
  VERSION_STRING='glib-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/glib/%minor_version%/glib-%version%.tar.bz2'
  )
}
