#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.12"

DIR="libusb-${VERSION}"
TARBALL="libusb-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/libusb/${TARBALL}
)

MD5SUMS=(
caf182cbc7565dac0fd72155919672e6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR \
    --disable-build-docs || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/libusb-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/projects/libusb/files/'
  VERSION_STRING='libusb-%version%.tar.gz'
  VERSION_FILTERS='/'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/libusb/libusb-%version%.tar.gz'
  )
}
