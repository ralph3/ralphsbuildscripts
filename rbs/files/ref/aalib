#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4rc5"

TARBALL="aalib-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
  python
)

SRC1=(
http://prdownloads.sourceforge.net/aa-project/${TARBALL}
)

MD5SUMS=(
9801095c42bba12edebd1902bcf0a990
)

build(){
  DIR=$(get_tarball_dir $DOWNLOADDIR/$TARBALL)
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --without-x || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/aalib-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=20003&package_id=14380'
  VERSION_STRING='aalib-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/aa-project/aalib-%version%.tar.gz"
  )
}
