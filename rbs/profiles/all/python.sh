#!/bin/bash

VERSION="2.6.4"

DIR="Python-${VERSION}"
TARBALL="Python-${VERSION}.tar.bz2"

DEPENDS=(
  bzip2
  openssl
  readline
  zlib
)

SRC1=(
http://www.python.org/ftp/python/${VERSION}/${TARBALL}
)

MD5SUMS=(
fee5408634a54e721a93531aba37f8c1
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch python-2.6-multilib-1.patch || return 1
  sed -i -e "s:@@MULTILIB_DIR@@:$LIBSDIR:g" \
    Lib/distutils/command/install.py \
    Lib/distutils/sysconfig.py \
    Lib/site.py \
    Makefile.pre.in \
    Modules/Setup.dist \
    Modules/getpath.c \
    setup.py || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/RBS-Tools \
    --libdir=/RBS-Tools/$LIBSDIR --enable-shared || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch python-2.6-multilib-1.patch || return 1
  sed -i -e "s:@@MULTILIB_DIR@@:$LIBSDIR:g" \
    Lib/distutils/command/install.py \
    Lib/distutils/sysconfig.py \
    Lib/site.py \
    Makefile.pre.in \
    Modules/Setup.dist \
    Modules/getpath.c \
    setup.py || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-shared || return 1
  make CFLAGS="$CFLAGS -O2" CXXFLAGS="$CXXFLAGS -O2" || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch \
    $TMPROOT/usr/bin/python{,$(echo ${VERSION} | cut -f-2 -d'.')} || return 1
  case $($CC -dumpmachine | cut -f1 -d'-') in
    x86_64)
      case $SYSTYPE in
        MULTILIB)
  if [ "$DISABLE_MULTILIB" != "1" ]; then
          mv -v $TMPROOT/usr/include/python$(echo $VERSION | cut -f-2 -d'.')/pyconfig{,-${USE_ARCH}}.h || return 1
cat > $TMPROOT/usr/include/python$(echo $VERSION | cut -f-2 -d'.')/pyconfig.h << "EOF" || return 1
#ifndef __STUB__PYCONFIG_H__
#define __STUB__PYCONFIG_H__

#if defined(__x86_64__) || \
    defined(__sparc64__) || \
    defined(__arch64__) || \
    defined(__powerpc64__) || \
    defined (__s390x__)
# include "pyconfig-64.h"
#else
# include "pyconfig-32.h"
#endif

#endif
EOF
  fi
        ;;
      esac
    ;;
  esac
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.python.org/ftp/python/%version%/'
  VERSION_STRING='Python-%version%.tar.bz2'
  MINOR_VERSION=2
  MIRRORS=(
    'http://www.python.org/ftp/python/%version%/Python-%version%.tar.bz2'
  )
}
