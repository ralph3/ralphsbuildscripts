#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.16.0"

DIR="ruby-gtk2-${VERSION}"
TARBALL="ruby-gtk2-${VERSION}.tar.gz"

DEPENDS=(
  ruby
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/ruby-gnome2/${TARBALL}
)

MD5SUMS=(
aedca2b3a7c6ae0f02cf5fd1e02f642c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/${DIR} || return 1
  do_patch ruby-gtk2-0.16.0-typedef-1.patch || return 1
  ruby ./extconf.rb || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/ruby-gnome2/'
  VERSION_STRING='ruby-gtk2-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/ruby-gnome2/ruby-gtk2-%version%.tar.gz"
  )
}
