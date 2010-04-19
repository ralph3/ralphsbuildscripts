#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.0.2"

DIR="libmusicbrainz-${VERSION}"
TARBALL="libmusicbrainz-${VERSION}.tar.gz"

DEPENDS=(
  cmake
)

SRC1=(
http://ftp.musicbrainz.org/pub/musicbrainz/${TARBALL}
)

MD5SUMS=(
648ecd43f7b80852419aaf73702bc23f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  cmake -DCC="$CC $BUILD" -DCXX="$CXX $BUILD" -DCMAKE_INSTALL_PREFIX:PATH=/usr \
    -DLIB_INSTALL_DIR:PATH=/usr/$LIBSDIR . || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.musicbrainz.org/pub/musicbrainz/'
  VERSION_STRING='libmusicbrainz-%version%.tar.gz'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    "http://ftp.musicbrainz.org/pub/musicbrainz/libmusicbrainz-%version%.tar.gz"
  )
}
