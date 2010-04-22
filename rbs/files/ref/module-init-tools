#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.11.1"

DIR="module-init-tools-${VERSION}"
TARBALL="module-init-tools-${VERSION}.tar.bz2"

DEPENDS=(
  zlib
)

SRC1=(
http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/${TARBALL}
)

MD5SUMS=(
28dfcb9e24cdbeb12b99ac1eb8af7dea
)

MyBuild(){
  
  MYDEST=$1
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  touch modprobe.conf.5 || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/ --enable-zlib \
    --with-moddir=/$LIBSDIR/modules || return 1
  sed -i '/MAN5 =/d;/MAN8 =/d' Makefile || return 1
  make || return 1
  make install DESTDIR=$MYDEST || return 1
  mv $MYDEST/bin/lsmod $MYDEST/sbin/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  MyBuild $ROOT || return 1
}

build(){
  MyBuild $TMPROOT || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/'
  VERSION_STRING='module-init-tools-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/module-init-tools-%version%.tar.bz2'
  )
}
