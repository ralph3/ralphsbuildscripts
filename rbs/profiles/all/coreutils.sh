#!/bin/bash

DISABLE_MULTILIB=1

VERSION="7.2"

DIR="coreutils-${VERSION}"
TARBALL="coreutils-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/coreutils/${TARBALL}
)

MD5SUMS=(
427c2914d3eab956f317c9ec6a45e62a
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "/binPROGRAMS_INSTALL=/s:./ginstall:install:" \
    src/Makefile.in || return 1
  echo "fu_cv_sys_stat_statfs2_bsize=yes" > config.cache || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools \
    --cache-file=config.cache || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo "fu_cv_sys_stat_statfs2_bsize=yes" > config.cache || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr \
    --enable-no-install-program=arch,kill,su,uptime,hostname \
    --cache-file=config.cache || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/{bin,usr/sbin}
  for x in basename cat chgrp chmod chown cp date dd df echo false head \
           install ln ls mkdir mknod mv pwd rm rmdir sync sleep stty \
           test touch true uname wc; do
    mv $TMPROOT/usr/bin/$x $TMPROOT/bin/ || return 1
  done
  mv $TMPROOT/usr/bin/chroot $TMPROOT/usr/sbin || return 1
  ln -sfn test $TMPROOT/bin/[ || return 1
  ln -sfn ../../bin/install $TMPROOT/usr/bin/install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/coreutils/'
  VERSION_STRING='coreutils-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/coreutils/coreutils-%version%.tar.gz'
  )
}
