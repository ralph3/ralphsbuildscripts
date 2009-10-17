#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.20"

DIR="binutils-${VERSION}"
TARBALL="binutils-${VERSION}.tar.bz2"

DEPENDS=(
  cloog-ppl
  zlib
)

SRC1=(
  http://ftp.gnu.org/gnu/binutils/${TARBALL}
)

MD5SUMS=(
ee2d3e996e9a2d669808713360fa96f8
)

###MyPatches="binutils-2.19.1-branch_update-3.patch binutils-2.19.1-posix-1.patch"

RBS_Cross_Tools_Build(){
  local PATCHES CONF PREF
  CONF=
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i386|i486|i586|i686)
      CONF="--disable-multilib"
    ;;
    x86_64)
      case $SYSTYPE in
        64BIT)
          CONF="--enable-64-bit-bfd --disable-multilib"
        ;;
        MULTILIB)
          CONF="--enable-64-bit-bfd"
        ;;
      esac
    ;;
  esac
  PREF="/RBS-Cross-Tools"
  if [ "$1" == "ToolsBuild" ]; then
    PREF="/RBS-Tools"
  else
    CONF="$CONF --with-sysroot=${ROOT}"
  fi
  
  CONF="--host="$BUILDHOST" --target="$BUILDTARGET" --prefix=$PREF --with-lib-path=/RBS-Tools/$LIBSDIR --disable-nls --enable-shared $CONF"
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  ###do_patch $MyPatches || return 1
  
  mkdir -p $SRCDIR/binutils-build || return 1
  cd $SRCDIR/binutils-build || return 1
  if [ "$1" == "ToolsBuild" ]; then
    CC="$CC $BUILD" ../$DIR/configure $CONF || return 1
  else
    AR=ar AS=as ../$DIR/configure $CONF || return 1
  fi
  make configure-host || return 1
  make || return 1
  make install || return 1
  cp ../$DIR/include/libiberty.h /RBS-Tools/include || return 1
  cd ../ || return 1
  rm -rf $DIR binutils-build || return 1
}

RBS_Tools_Build(){
  RBS_Cross_Tools_Build ToolsBuild || return 1
  return 0
}

build(){
  local PATCHES CONF
  CONF=
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i486|i586|i686)
      CONF="--disable-multilib"
    ;;
    x86_64)
      case $SYSTYPE in
        64BIT)
          CONF="--enable-64-bit-bfd --disable-multilib"
        ;;
        MULTILIB)
          CONF="--enable-64-bit-bfd"
        ;;
      esac
    ;;
  esac
  cd $SRCDIR || return 1
  rm -rf $DIR binutils-build || return 1
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  ###do_patch $MyPatches || return 1
  
  mkdir -p $SRCDIR/binutils-build || return 1
  cd $SRCDIR/binutils-build || return 1
  CC="$CC $BUILD -isystem /usr/include" LDFLAGS="-Wl,-rpath-link,/${LIBSDIR}" \
  ../$DIR/configure --prefix=/usr --libdir=/usr/$LIBSDIR \
    --enable-shared $CONF || return 1
  make configure-host || return 1
  make tooldir=/usr/$LIBSDIR/binutils || return 1
  make install tooldir=/usr/$LIBSDIR/binutils DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/include
  cp ../$DIR/include/libiberty.h $TMPROOT/usr/include || return 1
  cd ../ || return 1
  rm -rf $DIR binutils-build || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/binutils/'
  VERSION_STRING='binutils-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/binutils/binutils-%version%.tar.bz2'
  )
}
