#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.6.3"

DIR="sgml-common-${VERSION}"
TARBALL="sgml-common-${VERSION}.tgz"

DEPENDS=(
  make
)

SRC1=(
http://gd.tuwien.ac.at/hci/kde/devel/docbook/SOURCES/${TARBALL}
)


MD5SUMS=(
103c9828f24820df86e55e7862e28974
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch sgml-common-0.6.3-manpage-1.patch || return 1
  autoreconf -f -i || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  install-catalog --add /etc/sgml/sgml-ent.cat \
    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog || return 1
  install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/sgml-ent.cat \
    || return 1
}

pre_remove(){
  install-catalog --remove /etc/sgml/sgml-ent.cat \
    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog || return 1
  install-catalog --remove /etc/sgml/sgml-docbook.cat \
    /etc/sgml/sgml-ent.cat || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://gd.tuwien.ac.at/hci/kde/devel/docbook/SOURCES/'
  VERSION_STRING='sgml-common-%version%.tgz'
  MIRRORS=(
    'http://gd.tuwien.ac.at/hci/kde/devel/docbook/SOURCES/sgml-common-%version%.tgz'
  )
}
