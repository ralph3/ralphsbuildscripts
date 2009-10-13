#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.13"

DIR="gzip-${VERSION}"
TARBALL="gzip-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/gzip/${TARBALL}
)

MD5SUMS=(
c54a31b93e865f6a4410b2dc64662706
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "s/futimens/gl_&/" $(grep -lr futimens *) || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools || return 1
  sed -i 's@"BINDIR"@/bin@g' gzexe.in || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "s/futimens/gl_&/" $(grep -lr futimens *) || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  sed -i 's@"BINDIR"@/bin@g' gzexe.in || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/bin
  mv $TMPROOT/usr/bin/gzip $TMPROOT/bin || return 1
  rm $TMPROOT/usr/bin/{gunzip,zcat} || return 1
  ln -sfn gzip $TMPROOT/bin/gunzip || return 1
  ln -sfn gzip $TMPROOT/bin/zcat || return 1
  ln -sfn gzip $TMPROOT/bin/compress || return 1
  ln -sfn gunzip $TMPROOT/bin/uncompress || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gzip/'
  VERSION_STRING='gzip-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gzip/gzip-%version%.tar.gz'
  )
}
