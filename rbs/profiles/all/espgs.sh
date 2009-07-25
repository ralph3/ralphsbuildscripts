#!/bin/bash

DISABLE_MULTILIB=1

VERSION="7.07.1"
SYS_VERSION="7.07.1-1"

DIR="espgs-${VERSION}"
TARBALL="espgs-${VERSION}-source.tar.bz2"

DEPENDS=(
  cups
  libjpeg
  libpng
  libxext
  libxt
)

SRC1=(
http://prdownloads.sourceforge.net/espgs/${TARBALL}
)

MD5SUMS=(
d30bf5c09f2c7caa8291f6305cf03044
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR \
    install_prefix=$TMPROOT bindir=$TMPROOT/usr/bin \
    datadir=$TMPROOT/usr/share mandir=$TMPROOT/usr/share/man install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=18073&package_id=19793'
  VERSION_STRING='espgs-%version%-source.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/espgs/espgs-%version%-source.tar.bz2'
  )
}
