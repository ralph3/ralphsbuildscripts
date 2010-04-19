#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-vfs-${VERSION}"
TARBALL="gnome-vfs-${VERSION}.tar.bz2"

DEPENDS=(
  gconf
  gnome-mime-data
)

SRC1=(
  $(gnome_mirrors gnome-vfs)
)

MD5SUMS=(
646a2672c6e7e4ebff6a798b0fb7cc90
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-vfs-2.0 \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-vfs install || return 1
}

pre_remove(){
  gnome_script gnome-vfs remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-vfs/%minor_version%/'
  VERSION_STRING='gnome-vfs-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-vfs/%minor_version%/gnome-vfs-%version%.tar.bz2'
  )
}
