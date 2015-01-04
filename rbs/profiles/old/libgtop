#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.4"

DIR="libgtop-${VERSION}"
TARBALL="libgtop-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors libgtop)
)

MD5SUMS=(
cc2a6fb2c3f7d62ddb0e4040ad82cc5b
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

post_install(){
  gnome_script libgtop install || return 1
}

pre_remove(){
  gnome_script libgtop remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgtop/%minor_version%/'
  VERSION_STRING='libgtop-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libgtop/%minor_version%/libgtop-%version%.tar.bz2"
  )
}
