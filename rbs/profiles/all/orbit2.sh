#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.14.18"

DIR="ORBit2-${VERSION}"
TARBALL="ORBit2-${VERSION}.tar.bz2"

DEPENDS=(
  libidl
)

SRC1=(
  $(gnome_mirrors ORBit2)
)

MD5SUMS=(
3e80596171b1ea652707219c7144ff53
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/orbit2-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/ORBit2/%minor_version%/'
  VERSION_STRING='ORBit2-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/ORBit2/%minor_version%/ORBit2-%version%.tar.bz2"
  )
}
