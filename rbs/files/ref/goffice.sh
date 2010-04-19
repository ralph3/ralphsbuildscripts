#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.6.6"

DIR="goffice-${VERSION}"
TARBALL="goffice-${VERSION}.tar.bz2"

DEPENDS=(
  libgsf
  pcre
)

SRC1=(
  $(gnome_mirrors goffice)
)

MD5SUMS=(
92e51878b9cd9c2fa954953d708f2c47
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/goffice \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script goffice install || return 1
}

pre_remove(){
  gnome_script goffice remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/goffice/%minor_version%/'
  VERSION_STRING='goffice-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/goffice/%minor_version%/goffice-%version%.tar.bz2'
  )
}
