#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.8.4"

DIR="gnumeric-${VERSION}"
TARBALL="gnumeric-${VERSION}.tar.bz2"

DEPENDS=(
  goffice
)

SRC1=(
  $(gnome_mirrors gnumeric)
)

MD5SUMS=(
338f0084f04a16f78797ad01f85d3251
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnumeric \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  mkdir -vp $TMPROOT/usr/share/gnumeric/$VERSION/doc || return 1
  cp -va doc/C $TMPROOT/usr/share/gnumeric/$VERSION/doc/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnumeric install || return 1
}

pre_remove(){
  gnome_script gnumeric remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnumeric/%minor_version%/'
  VERSION_STRING='gnumeric-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnumeric/%minor_version%/gnumeric-%version%.tar.bz2'
  )
}
