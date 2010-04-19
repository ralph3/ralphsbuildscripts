#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.2"
SYS_VERSION="1.3.2-1"

DIR="openjade-${VERSION}"
TARBALL="openjade-${VERSION}.tar.gz"

DEPENDS=(
  opensp
)

SRC1=(
http://prdownloads.sourceforge.net/openjade/${TARBALL}
)

MD5SUMS=(
7df692e3186109cc00db6825b777201e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-splibdir=/usr/$LIBSDIR \
    --enable-http --disable-static \
    --enable-default-catalog=/etc/sgml/catalog \
    --enable-default-search-path=/usr/share/sgml \
    --datadir=/usr/share/sgml/openjade-${VERSION} || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  ln -sf openjade $TMPROOT/usr/bin/jade || return 1
  ln -sf libogrove.so $TMPROOT/usr/$LIBSDIR/libgrove.so || return 1
  ln -sf libospgrove.so $TMPROOT/usr/$LIBSDIR/libspgrove.so || return 1
  ln -sf libostyle.so $TMPROOT/usr/$LIBSDIR/libstyle.so || return 1
  install -m644 dsssl/catalog \
    $TMPROOT/usr/share/sgml/openjade-${VERSION}/ || return 1
  install -m644 dsssl/*.{dtd,dsl,sgm} \
    $TMPROOT/usr/share/sgml/openjade-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  install-catalog --add /etc/sgml/openjade-${VERSION}.cat \
    /usr/share/sgml/openjade-${VERSION}/catalog || return 1
  install-catalog --add /etc/sgml/sgml-docbook.cat \
    /etc/sgml/openjade-${VERSION}.cat || return 1
}

pre_remove(){
  if [ -e "/etc/sgml/openjade-${VERSION}.cat" ]; then
    install-catalog --remove /etc/sgml/openjade-${VERSION}.cat \
      /usr/share/sgml/openjade-${VERSION}/catalog || return 1
    install-catalog --remove /etc/sgml/sgml-docbook.cat \
      /etc/sgml/openjade-${VERSION}.cat || return 1
  fi
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/openjade/'
  VERSION_STRING='openjade-%version%.tar.gz'
  VERSION_FILTERS='pre rc'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/openjade/openjade-%version%.tar.gz'
  )
}
