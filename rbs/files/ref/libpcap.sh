#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.1"

DIR="libpcap-${VERSION}"
TARBALL="libpcap-${VERSION}.tar.gz"

DEPENDS=(
  flex
)

SRC1=(
http://www.tcpdump.org/release/${TARBALL}
)

MD5SUMS=(
1bca27d206970badae248cfa471bbb47
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo "ac_cv_linux_vers=2" > config.cache || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR \
    --with-pcap=linux --cache-file=config.cache || return 1
  make || return 1
  mkdir -p $TMPROOT/usr/bin || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.tcpdump.org/release/'
  VERSION_STRING='libpcap-%version%.tar.gz'
  MIRRORS=(
    'http://www.tcpdump.org/release/libpcap-%version%.tar.gz'
  )
}
