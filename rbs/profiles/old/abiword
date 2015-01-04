#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.6"

DIR="abiword-${VERSION}"
TARBALL="abiword-${VERSION}.tar.gz"

DEPENDS=(
  wv1
)

SRC1=(
http://www.abisource.com/downloads/abiword/$VERSION/source/$TARBALL
)

MD5SUMS=(
b9de84f03f555d4490b63e5b7f53e2f1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script abiword install || return 1
}

pre_remove(){
  gnome_script abiword remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://www.abisource.com/downloads/abiword/%version%/source/'
  VERSION_STRING='abiword-%version%.tar.gz'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://www.abisource.com/downloads/abiword/%version%/source/abiword-%version%.tar.gz'
  )
}
