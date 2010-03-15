#!/bin/bash

VERSION="1.53"

DIR="URI-${VERSION}"
TARBALL="URI-${VERSION}.tar.gz"

DEPENDS=(
  perl
)

SRC1=(
http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/${TARBALL}
)

MD5SUMS=(
6171fddb5b93c1b4f0da5af6fc24e145
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
  ADDRESS='http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/'
  VERSION_STRING='URI-%version%.tar.gz'
  MIRRORS=(
    'http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/URI-%version%.tar.gz'
  )
}
