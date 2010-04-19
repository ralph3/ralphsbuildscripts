#!/bin/bash

DISABLE_MULTILIB=1

VERSION="7.8"

DIR="pcre-${VERSION}"
TARBALL="pcre-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${TARBALL}
)

MD5SUMS=(
141132d6af14dccc7b08fa797e4fd441
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr --enable-utf8 \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/pcre-config || return 1
  install -v -m755 -d \
    $TMPROOT/usr/share/doc/pcre-${VERSION}/html || return 1
  install -v -m644 doc/html/* \
    $TMPROOT/usr/share/doc/pcre-${VERSION}/html || return 1
  install -v -m644 doc/*.txt \
    $TMPROOT/usr/share/doc/pcre-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/'
  VERSION_STRING='pcre-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-%version%.tar.bz2'
  )
}
