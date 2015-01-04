#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.2.8"

DIR="gnucash-${VERSION}"
TARBALL="gnucash-${VERSION}.tar.bz2"

DEPENDS=(
  goffice
  gtk+
  gtkhtml
  slib
)

SRC1=(
  http://ftp.at.gnucash.org/pub/gnucash/gnucash/sources/stable/$TARBALL
  http://www.gnucash.org/pub/gnucash/sources/stable/$TARBALL
)

MD5SUMS=(
79d37e4fa0c71722e093136655698924
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnucash \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnucash install || return 1
}

pre_remove(){
  gnome_script gnucash remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://www.gnucash.org/pub/gnucash/sources/stable/'
  VERSION_STRING='gnucash-%version%.tar.bz2'
  MIRRORS=(
    'http://www.gnucash.org/pub/gnucash/sources/stable/gnucash-%version%.tar.bz2'
  )
}
