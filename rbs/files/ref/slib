#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3b1"

DIR="slib"
TARBALL="slib-${VERSION}.tar.gz"

DEPENDS=(
  guile
)

SRC1=(
http://swiss.csail.mit.edu/ftpdir/scm/OLD/$TARBALL
http://swiss.csail.mit.edu/ftpdir/scm/$TARBALL
)

MD5SUMS=(
6b14254aba8d59ede3bfb5a586ee7718
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make catalogs || return 1
  make install prefix=/usr/ libdir=/usr/share/guile/ \
    DESTDIR=$TMPROOT || return 1
  sed -i "s%${TMPROOT}%/%g" $(grep -rl "$TMPROOT" $TMPROOT) || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  if [ ! -e "/usr/share/guile/site/slibcat" ]; then
    mkdir -p /usr/share/guile/site/ || return 1
    touch /usr/share/guile/site/slibcat || return 1
  fi
  guile -c "(use-modules (ice-9 slib)) (require 'new-catalog)" || return 1
}

post_upgrade(){
  post_install || return 1
}

#version_check_info(){
#  ADDRESS='http://swiss.csail.mit.edu/ftpdir/scm/'
#  VERSION_STRING='slib-%version%.tar.gz'
#  MIRRORS=(
#    'http://swiss.csail.mit.edu/ftpdir/scm/slib-%version%.tar.gz'
#  )
#}
