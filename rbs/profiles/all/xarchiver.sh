#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20100325"

DIR="xarchiver-${VERSION}"
TARBALL="xarchiver-${VERSION}.tar.xz"

DEPENDS=(
  make
)

my_src1(){
  rm -rf $DIR || return 1
  git clone git://138.48.2.101/apps/xarchiver || return 1
  mv xarchiver $DIR || return 1
  cd $DIR || return 1
  git checkout $(git rev-list --all --max-age=$(date +%s -d19700101) \
    --min-age=$(date +%s -d$(echo $VERSION | cut -f2- -d'-')) -n1) || return 1
  cd ../ || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  sed -i -e 's%Xarchiver%Archive Manager%' \
    $TMPROOT/usr/share/applications/xarchiver.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
