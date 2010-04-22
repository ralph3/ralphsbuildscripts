#!/bin/bash

VERSION="1.8.0"

TARBALL="ruby-${VERSION}.tar.gz"
DIR="ruby-${VERSION}"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.ruby-lang.org/pub/ruby/$(echo $VERSION | cut -f-2 -d'.')/$TARBALL
)

MD5SUMS=(
582a65e52598a4a1e9fce523e16e67d6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "s:/lib/ruby:/${LIBSDIR}/ruby:g" configure || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-shared --enable-pthread \
    --enable-install-doc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/ruby || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

#version_check_info(){
#  ADDRESS='ftp://ftp.ruby-lang.org/pub/ruby/%minor_version%/'
#  VERSION_STRING='ruby-%version%.tar.gz'
#  VERSION_FILTERS='[a-z] [A-Z]'
#  MIRRORS=(
#    "ftp://ftp.ruby-lang.org/pub/ruby/%minor_version%/ruby-%version%.tar.gz"
#  )
#}

