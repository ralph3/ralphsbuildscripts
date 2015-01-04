#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.5.2"
SYS_VERSION="1.5.2-1"

DIR="OpenSP-${VERSION}"
TARBALL="OpenSP-${VERSION}.tar.gz"

DEPENDS=(
  sgml-common
)

SRC1=(
http://prdownloads.sourceforge.net/openjade/${TARBALL}
)

MD5SUMS=(
670b223c5d12cee40c9137be86b6c39b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --disable-static --enable-http \
    --enable-default-catalog=/etc/sgml/catalog \
    --enable-default-search-path=/usr/share/sgml --disable-doc-build || return 1
  make pkgdatadir=/usr/share/sgml/OpenSP-${VERSION} || return 1
  make pkgdatadir=/usr/share/sgml/OpenSP-${VERSION} install \
    DESTDIR=$TMPROOT || return 1
  ln -sfn onsgmls $TMPROOT/usr/bin/nsgmls || return 1
  ln -sfn osgmlnorm $TMPROOT/usr/bin/sgmlnorm || return 1
  ln -sfn ospam $TMPROOT/usr/bin/spam || return 1
  ln -sfn ospcat $TMPROOT/usr/bin/spcat || return 1
  ln -sfn ospent $TMPROOT/usr/bin/spent || return 1
  ln -sfn osx $TMPROOT/usr/bin/sx || return 1
  ln -sfn osx $TMPROOT/usr/bin/sgml2xml || return 1
  ln -sfn libosp.so $TMPROOT/usr/$LIBSDIR/libsp.so || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/openjade/'
  VERSION_STRING='OpenSP-%version%.tar.gz'
  VERSION_FILTERS='pre rc'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/openjade/OpenSP-%version%.tar.gz'
  )
}
