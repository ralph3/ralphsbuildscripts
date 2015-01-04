#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.1"

DIR="gepolabo-${VERSION}"
TARBALL="gepolabo-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
  mysql
)

SRC1=(
  http://download.gna.org/gepolabo/v${VERSION}/$TARBALL
)

MD5SUMS=(
89beb00713f3a52bb5a12a2f765cc855
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gepolabo \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  mkdir -p \
    $TMPROOT/usr/share/gepolabo/{sql,web/{seance,histo,intraday},sounds} \
    $TMPROOT/usr/share/gnome/help/gepolabo/C/figures || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gepolabo install || return 1
}

pre_remove(){
  gnome_script gepolabo remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://home.gna.org/gepolabo/en/telechargement.htm'
  VERSION_STRING='gepolabo-%version%.tar.gz'
  MIRRORS=(
    'http://download.gna.org/gepolabo/v%version%/gepolabo-%version%.tar.gz'
  )
}
