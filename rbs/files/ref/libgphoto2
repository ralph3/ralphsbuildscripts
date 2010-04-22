#!/bin/bash

DISABLE_MULTILIB=1

#2.4.2 breaks gthumb 2.10.8
VERSION="2.4.1"

DIR="libgphoto2-${VERSION}"
TARBALL="libgphoto2-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/gphoto/${TARBALL}
)

MD5SUMS=(
49c12c52031da50153d7fbd75b49124d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --with-ltdl \
    --with-drivers=all || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/gphoto2{,-port}-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/gphoto/'
  VERSION_STRING='libgphoto2-%version%.tar.gz'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gphoto/libgphoto2-%version%.tar.gz'
  )
}
