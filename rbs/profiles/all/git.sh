#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6.3.3"

DIR="git-${VERSION}"
TARBALL="git-${VERSION}.tar.bz2"

DEPENDS=(
  curl
  expat
)

SRC1=(
http://kernel.org/pub/software/scm/git/${TARBALL}
)

MD5SUMS=(
91ae46ac01dadab1962beb064abd5b60
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr --sysconfdir=/etc \
    --libexecdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://kernel.org/pub/software/scm/git/'
  VERSION_STRING='git-%version%.tar.bz2'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://kernel.org/pub/software/scm/git/git-%version%.tar.bz2'
  )
}
