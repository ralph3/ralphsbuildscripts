#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.6"
SYS_VERSION="0.2.6-1"


DIR="audiofile-${VERSION}"
TARBALL="audiofile-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.acc.umu.se/pub/GNOME/sources/audiofile/0.2/${TARBALL}
)

MD5SUMS=(
3d01302834660850b6141cac1e6f5501
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/audiofile-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.acc.umu.se/pub/GNOME/sources/audiofile/%minor_version%/'
  VERSION_STRING='audiofile-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.acc.umu.se/pub/GNOME/sources/audiofile/%minor_version%/audiofile-%version%.tar.bz2'
  )
}