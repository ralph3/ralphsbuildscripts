#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.3"

DIR="imlib2-${VERSION}"
TARBALL="imlib2-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
  http://prdownloads.sourceforge.net/enlightenment/$TARBALL
)

MD5SUMS=(
cdac0d47eca6023e3e2a18584d3f6940
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc/imlib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/imlib-config || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/imlib-${VERSION} || return 1
  install -v -m644 doc/{index.html,*.gif} \
    $TMPROOT/usr/share/doc/imlib-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/projects/enlightenment/files/'
  VERSION_STRING='imlib2-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://prdownloads.sourceforge.net/enlightenment/imlib2-%version%.tar.bz2"
  )
}
