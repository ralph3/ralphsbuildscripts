#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.9"

DIR="libidn-${VERSION}"
TARBALL="libidn-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://josefsson.org/libidn/releases/${TARBALL}
)

MD5SUMS=(
f4d794639564256a367566302611224e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  find doc -name "Makefile*" -exec rm {} \; &&
  install -v -m755 -d \
    /usr/share/doc/libidn-${VERSION}/{api,java,specifications,tld} || return 1
  install -v -m644 doc/components* \
    doc/libidn.{pdf,ps,html} \
    /usr/share/doc/libidn-${VERSION} || return 1
  install -v -m644 doc/reference/html/* \
    /usr/share/doc/libidn-${VERSION}/api || return 1
  install -v -m644 doc/specifications/* \
    /usr/share/doc/libidn-${VERSION}/specifications || return 1
  install -v -m644 doc/tld/* /usr/share/doc/libidn-${VERSION}/tld || return 1
  cp -v -R doc/java/* /usr/share/doc/libidn-${VERSION}/java || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://josefsson.org/libidn/releases/'
  VERSION_STRING='libidn-%version%.tar.gz'
  MIRRORS=(
    'http://josefsson.org/libidn/releases/libidn-%version%.tar.gz'
  )
}
