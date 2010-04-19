#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-games-${VERSION}"
TARBALL="gnome-games-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-python
  guile
  ggz-client-libs
)

SRC1=(
  $(gnome_mirrors gnome-games)
)

MD5SUMS=(
e416e2922fe119c41ec224fab97f7909
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  groupadd games
  useradd -c 'Games High Score Owner' -d /var/lib/games -g games \
    -s /bin/false games
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/var/lib/games
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-games install || return 1
  chown -R games:games /var/lib/games || return 1
}

pre_remove(){
  gnome_script gnome-games remove || return 1
}

post_remove(){
  userdel games
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-games/%minor_version%/'
  VERSION_STRING='gnome-games-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-games/%minor_version%/gnome-games-%version%.tar.bz2'
  )
}
