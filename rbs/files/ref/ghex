#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.22.0"

DIR="ghex-${VERSION}"
TARBALL="ghex-${VERSION}.tar.bz2"

DEPENDS=(
  gail
  libgnomeprintui
  libgnomeui
)

SRC1=(
  $(gnome_mirrors ghex)
)

MD5SUMS=(
6f1ee7a56f7dd04bfba5ee74a639948a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  set_multiarch $TMPROOT/usr/bin/ghex2 || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script ghex install || return 1
}

pre_remove(){
  gnome_script ghex remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/ghex/%minor_version%/'
  VERSION_STRING='ghex-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/ghex/%minor_version%/ghex-%version%.tar.bz2'
  )
}
