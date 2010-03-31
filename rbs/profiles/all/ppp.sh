#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.5"
SYS_VERSION="2.4.5-1"

DIR="ppp-${VERSION}"
TARBALL="ppp-${VERSION}.tar.gz"

DEPENDS=(
  libpcap
)

SRC1=(
http://samba.org/ftp/ppp/${TARBALL}
)

MD5SUMS=(
4621bc56167b6953ec4071043fe0ec57
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "s%/lib/pppd%/${LIBSDIR}/pppd%g" $(grep -rl "/lib/pppd" *) || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  find -name 'Makefile' -exec \
    sed -i 's%$(INSTALL) -s%$(INSTALL)%g' {} \; || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install DESTDIR=$TMPROOT/usr || return 1
  make install-etcppp ETCDIR=$TMPROOT/etc/ppp || return 1
  for file in $TMPROOT/etc/ppp/*; do
    mv $file ${file}.tmpnew || return 1
  done
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://samba.org/ftp/ppp/'
  VERSION_STRING='ppp-%version%.tar.gz'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://samba.org/ftp/ppp/ppp-%version%.tar.gz'
  )
}
