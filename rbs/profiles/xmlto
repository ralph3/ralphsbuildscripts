#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.20"

DIR="xmlto-${VERSION}"
TARBALL="xmlto-${VERSION}.tar.bz2"

DEPENDS=(
  docbook-xml
  docbook-xsl
  libxslt
)

SRC1=(
http://cyberelk.net/tim/data/xmlto/stable/${TARBALL}
)

MD5SUMS=(
ab814ae352fc028862cbea9d676ab93b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://cyberelk.net/tim/data/xmlto/stable/"
  VERSION_STRING="xmlto-%version%.tar.bz2"
  MIRRORS=(
    "http://cyberelk.net/tim/data/xmlto/stable/xmlto-%version%.tar.bz2"
  )
}
