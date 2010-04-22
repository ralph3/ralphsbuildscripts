#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="gnome-common-${VERSION}"
TARBALL="gnome-common-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-common)
)

MD5SUMS=(
f72230d19ab9f2fa8923dcb078c69e9a
)

#my_src1(){
#  cvs -z3 -d:pserver:anonymous:@anoncvs.gnome.org:/cvs/gnome \
#    export -D $(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%') \
#    -d $DIR \
#    gnome-common || return 1
#}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-common/%minor_version%/'
  VERSION_STRING='gnome-common-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-common/%minor_version%/gnome-common-%version%.tar.bz2'
  )
}
