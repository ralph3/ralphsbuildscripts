#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.6"


DIR="audacity-src-${VERSION}"
TARBALL="audacity-src-${VERSION}.tar.gz"

DEPENDS=(
  libsndfile
  wxwidgets
)

SRC1=(
http://prdownloads.sourceforge.net/audacity/${TARBALL}
)

MD5SUMS=(
d9fecebc558ed62f2b9ef0624ce9493d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/${DIR}* || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/audacity/'
  VERSION_STRING='audacity-src-%version%.tar.gz'
  ##ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://prdownloads.sourceforge.net/audacity/audacity-src-%version%.tar.gz"
  )
}
