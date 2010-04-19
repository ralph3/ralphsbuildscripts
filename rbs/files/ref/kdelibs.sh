#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.0"

DIR="kdelibs-${VERSION}"
TARBALL="kdelibs-${VERSION}.tar.bz2"

DEPENDS=(
  aspell-en
  gamin
  arts
  libart_lgpl
  libidn
  libtiff
  libxslt
  openssl
  pcre
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
2d830a922195fefe6e073111850247ac
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/kde-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='kdelibs-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/kdelibs-%version%.tar.bz2'
  )
}
