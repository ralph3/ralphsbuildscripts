#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.28.1"

DIR="GConf-${VERSION}"
TARBALL="GConf-${VERSION}.tar.bz2"

DEPENDS=(
  orbit2
  policykit
)

SRC1=(
  $(gnome_mirrors GConf)
)

MD5SUMS=(
27663faf0af4f6a6d534de9270f6d24a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/GConf \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --enable-defaults-service || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/GConf/%minor_version%/'
  VERSION_STRING='GConf-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/GConf/%minor_version%/GConf-%version%.tar.bz2'
  )
}
