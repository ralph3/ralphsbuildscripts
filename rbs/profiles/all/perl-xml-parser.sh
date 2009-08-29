#!/bin/bash

VERSION="2.36"
SYS_VERSION="2.36-3"

DIR="XML-Parser-${VERSION}"
TARBALL="XML-Parser-${VERSION}.tar.gz"

DEPENDS=(
  expat
)

SRC1=(
http://www.cpan.org/authors/id/M/MS/MSERGEANT/${TARBALL}
)

MD5SUMS=(
1b868962b658bd87e1563ecd56498ded
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  perl Makefile.PL || return 1
  make || return 1
  make test || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.cpan.org/authors/id/M/MS/MSERGEANT/'
  VERSION_STRING='XML-Parser-%version%.tar.gz'
  MIRRORS=(
    'http://www.cpan.org/authors/id/M/MS/MSERGEANT/XML-Parser-%version%.tar.gz'
  )
}
