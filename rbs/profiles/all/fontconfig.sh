#!/bin/bash

VERSION="2.7.3"

DIR="fontconfig-${VERSION}"
TARBALL="fontconfig-${VERSION}.tar.gz"

DEPENDS=(
  expat
  freetype
)

SRC1=(
http://fontconfig.org/release/${TARBALL}
)

MD5SUMS=(
747d2c691c66b563c8e8c1784ce8d014
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --localstatedir=/var --disable-docs --without-add-fonts \
    --with-docdir=/usr/share/doc/fontconfig-${VERSION} \
    --libdir=/usr/$LIBSDIR \
    --with-default-fonts="/usr/share/X11/fonts" || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/usr/share/man/man{3,5} || return 1
  install -v -m644 doc/*.3 $TMPROOT/usr/share/man/man3/ || return 1
  install -v -m644 doc/*.5 $TMPROOT/usr/share/man/man5/ || return 1
  mkdir -vp \
    $TMPROOT/usr/share/doc/fontconfig-${VERSION}/fontconfig-devel || return 1
  install -v -m644 doc/*.{html,pdf,txt} \
    $TMPROOT/usr/share/doc/fontconfig-${VERSION} || return 1
  install -v -m644 doc/fontconfig-devel/* \
    $TMPROOT/usr/share/doc/fontconfig-${VERSION}/fontconfig-devel || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://fontconfig.org/release/'
  VERSION_STRING='fontconfig-%version%.tar.gz'
  VERSION_FILTERS='\.9.$'
  MIRRORS=(
    'http://fontconfig.org/release/fontconfig-%version%.tar.gz'
  )
}
