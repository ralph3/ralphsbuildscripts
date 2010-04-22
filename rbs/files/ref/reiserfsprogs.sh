#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.6.21"

DIR="reiserfsprogs-${VERSION}"
TARBALL="reiserfsprogs-${VERSION}.tar.gz"

DEPENDS=(
  e2fsprogs
)

SRC1=(
http://www.kernel.org/pub/linux/utils/fs/reiserfs/${TARBALL}
)

MD5SUMS=(
bc00c7c4e047902575dc4e1c64ab3ba4
)

MyBuild(){
  
  MYDEST=$1
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --sbindir=/sbin || return 1
  make || return 1
  make install DESTDIR=$MYDEST || return 1
  ln -sfn reiserfsck $MYDEST/sbin/fsck.reiserfs || return 1
  ln -sfn mkreiserfs $MYDEST/sbin/mkfs.reiserfs || return 1
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
  ADDRESS='http://www.kernel.org/pub/linux/utils/fs/reiserfs/'
  VERSION_STRING='reiserfsprogs-%version%.tar.gz'
  VERSION_FILTERS='x'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/utils/fs/reiserfs/reiserfsprogs-%version%.tar.gz'
  )
}