#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="nautilus-cd-burner-${VERSION}"
TARBALL="nautilus-cd-burner-${VERSION}.tar.bz2"

DEPENDS=(
  nautilus
)

SRC1=(
  $(gnome_mirrors nautilus-cd-burner)
)

MD5SUMS=(
eb211dd03d0518263fa4eadccc3caa88
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/nautilus-cd-burner \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script nautilus-cd-burner install || return 1
}

pre_remove(){
  gnome_script nautilus-cd-burner remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/nautilus-cd-burner/%minor_version%/'
  VERSION_STRING='nautilus-cd-burner-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/nautilus-cd-burner/%minor_version%/nautilus-cd-burner-%version%.tar.bz2'
  )
}
