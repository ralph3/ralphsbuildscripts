#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.4.1"

DIR="evolution-data-server-${VERSION}"
TARBALL="evolution-data-server-${VERSION}.tar.bz2"

DEPENDS=(
  firefox
  libsoup
  sqlite
)

SRC1=(
  $(gnome_mirrors evolution-data-server)
)

MD5SUMS=(
3d6234ec417b2d9ab8dac6c45ec6ba97
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/evolution-data-server \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --with-nspr-includes=/usr/include/firefox \
    --with-nspr-libs=/usr/$LIBSDIR/firefox \
    --with-nss-includes=/usr/include/firefox \
    --with-nss-libs=/usr/$LIBSDIR/firefox \
    --enable-nss || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script evolution-data-server install || return 1
}

pre_remove(){
  gnome_script evolution-data-server remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/evolution-data-server/%minor_version%/'
  VERSION_STRING='evolution-data-server-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/evolution-data-server/%minor_version%/evolution-data-server-%version%.tar.bz2'
  )
}
