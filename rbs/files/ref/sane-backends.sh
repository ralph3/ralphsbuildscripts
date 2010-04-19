#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.19"

DIR="sane-backends-${VERSION}"
TARBALL="sane-backends-${VERSION}.tar.gz"

DEPENDS=(
  libgphoto2
)

SRC1=(
ftp://ftp.sane-project.org/pub/sane/sane-backends-${VERSION}/${TARBALL}
)

MD5SUMS=(
8c0936272dcfd4e98c51512699f1c06f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/sane-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.sane-project.org/pub/sane/sane-backends-%version%/'
  VERSION_STRING='sane-backends-%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.sane-project.org/pub/sane/sane-backends-%version%/sane-backends-%version%.tar.gz'
  )
}
