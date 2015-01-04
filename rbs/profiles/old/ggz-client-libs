#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.14.1"

DIR="ggz-client-libs-${VERSION}"
TARBALL="ggz-client-libs-${VERSION}.tar.gz"

DEPENDS=(
  libggz
)

SRC1=(
http://ftp.belnet.be/packages/ggzgamingzone/ggz/$VERSION/${TARBALL}
)

MD5SUMS=(
299eaa93721b1d867b5bf7dc6ac764b0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.belnet.be/packages/ggzgamingzone/ggz/%version%/'
  VERSION_STRING='ggz-client-libs-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.belnet.be/packages/ggzgamingzone/ggz/%version%/ggz-client-libs-%version%.tar.gz'
  )
}
