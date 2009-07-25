#!/bin/bash

VERSION="2.18"
SYS_VERSION="2.18-1"

DIR="XML-Simple-${VERSION}"
TARBALL="XML-Simple-${VERSION}.tar.gz"

DEPENDS=(
  perl
)

SRC1=(
http://www.cpan.org/authors/id/G/GR/GRANTM/${TARBALL}
)

MD5SUMS=(
593aa8001e5c301cdcdb4bb3b63abc33
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
  ADDRESS='http://www.cpan.org/authors/id/G/GR/GRANTM/'
  VERSION_STRING='XML-Simple-%version%.tar.gz'
  MIRRORS=(
    'http://www.cpan.org/authors/id/G/GR/GRANTM/XML-Simple-%version%.tar.gz'
  )
}
