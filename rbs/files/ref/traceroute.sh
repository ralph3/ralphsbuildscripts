#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4a12"

DIR="traceroute-${VERSION}"
TARBALL="traceroute-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://gd.tuwien.ac.at/platform/sun/packages/solaris/freeware/SOURCES/${TARBALL}
)

MD5SUMS=(
964d599ef696efccdeebe7721cd4828d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch traceroute-1.4a12-update_config-1.patch || return 1
  sed -i -e 's/-o bin/-o root/' Makefile.in || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  mkdir -vp $TMPROOT/usr/{man/man8,sbin} || return 1
  make install DESTDIR=$TMPROOT || return 1
  make install-man DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://gd.tuwien.ac.at/platform/sun/packages/solaris/freeware/SOURCES/'
  VERSION_STRING='traceroute-%version%.tar.gz'
  MIRRORS=(
    "http://gd.tuwien.ac.at/platform/sun/packages/solaris/freeware/SOURCES/traceroute-%version%.tar.gz"
  )
}
