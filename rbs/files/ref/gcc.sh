#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.5.0"

DIR="gcc-${VERSION}"
TARBALL="gcc-${VERSION}.tar.bz2"

DEPENDS=(
  binutils
)

SRC1=(
http://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/$TARBALL
ftp://sources.redhat.com/pub/gcc/releases/gcc-${VERSION}/$TARBALL
)

MD5SUMS=(
ff27b7c4a5d5060c8a8543a44abca31f
)

GCC_Switch_ToolChain(){
  echo -n "GCC: Switching the toolchain..."
  gcc -dumpspecs | perl -p -e 's@/RBS-Tools/lib/ld@/lib/ld@g;' \
                           -e 's@/RBS-Tools/lib64/ld@/lib64/ld@g;' \
                           -e 's@\*startfile_prefix_spec:\n@$_/usr/lib/ @g;' > \
    $(dirname $(gcc --print-libgcc-file-name))/specs || return 1
  echo "  Done."
  return 0
}

My_GCC_MultiBuild_Func(){
  local CONF F
  CONF=
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i386|i486|i586|i686)
      CONF="--disable-multilib"
    ;;
    x86_64)
      case $SYSTYPE in
        64BIT)
          CONF="--disable-multilib"
        ;;
      esac
    ;;
  esac
  
  case $1 in
    CrossToolsStatic)
      CONF="--prefix=/RBS-Cross-Tools --with-local-prefix=/RBS-Tools --with-sysroot=$ROOT --build=$BUILDHOST --host=$BUILDHOST --target=$BUILDTARGET --disable-nls $CONF --disable-shared --without-headers --with-newlib --disable-decimal-float --disable-libgomp --disable-libmudflap --disable-libssp --disable-threads --enable-languages=c --with-mpfr=/RBS-Cross-Tools --with-gmp=/RBS-Cross-Tools --with-mpc=/RBS-Cross-Tools --without-ppl --without-cloog"
    ;;
    CrossTools)
      CONF="--prefix=/RBS-Cross-Tools --with-local-prefix=/RBS-Tools --with-sysroot=$ROOT --build=$BUILDHOST --host=$BUILDHOST --target=$BUILDTARGET --disable-nls $CONF --enable-shared --enable-languages=c,c++ --enable-__cxa_atexit --enable-c99 --enable-long-long --enable-threads=posix --with-mpfr=/RBS-Cross-Tools --with-gmp=/RBS-Cross-Tools --with-mpc=/RBS-Cross-Tools --without-ppl --without-cloog"
    ;;
    Tools)
      CONF="--prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR --libexecdir=/RBS-Tools/$LIBSDIR --with-local-prefix=/RBS-Tools --build=$BUILDHOST --host=$BUILDTARGET --target=$BUILDTARGET --enable-long-long --enable-c99 --enable-shared --enable-threads=posix --enable-__cxa_atexit --disable-nls --enable-languages=c,c++ --disable-libstdcxx-pch --without-ppl --without-cloog $CONF"
    ;;
    Standard)
      CONF="--prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-c99 --enable-long-long --enable-clocale=gnu --enable-languages=c,c++ --disable-libstdcxx-pch --without-ppl --without-cloog $CONF"
    ;;
  esac
  
  rm -rf $HDSRCDIR/gcc-build $HDSRCDIR
  mkdir -p $HDSRCDIR/gcc-build $HDSRCDIR || return 1
  echo -n "Unpacking ${TARBALL}..."
  tar xfj $DOWNLOADDIR/$TARBALL -C $HDSRCDIR || return 1
  echo "Done."
  cd $HDSRCDIR/$DIR || return 1
  
  case $1 in
    CrossToolsStatic|CrossTools|Tools)
      for x in $(find gcc/config -name linux64.h -o -name linux.h); do
        sed -i -e 's@/lib\(64\)\?\(32\)\?/ld@/RBS-Tools&@g' \
          -e 's@/usr@/RBS-Tools@g' $x || return 1
cat << FOE >> $x || return 1
#undef STANDARD_INCLUDE_DIR
#define STANDARD_INCLUDE_DIR 0
FOE
      done
    ;;
  esac

  case $1 in
    CrossToolsStatic|CrossTools)
cat << FOO >> gcc/config/linux.h || return 1
#undef STARTFILE_PREFIX_SPEC
#define STARTFILE_PREFIX_SPEC "/RBS-Tools/$LIBSDIR/"
FOO
    ;;
  esac

  case $1 in
    CrossToolsStatic|CrossTools)
      sed -i -e "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 /RBS-Tools/include@g" \
        gcc/Makefile.in || return 1
    ;;
  esac
  
  case $1 in
    Tools)
      sed -i -e '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@0@g' \
        gcc/cppdefault.c || return 1
      sed -i -e 's@\(^NATIVE_SYSTEM_HEADER_DIR =\).*@\1 /RBS-Tools/include@g' \
        gcc/Makefile.in || return 1
    ;;
    Standard)
      sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in || return 1
    ;;
  esac
  
  cd $HDSRCDIR/gcc-build || return 1
  
  case $1 in
    Standard)
      CC="$CC $BUILD -Wl,-rpath-link,/${LIBSDIR} -isystem /usr/include" \
        CXX="$CXX $BUILD -Wl,-rpath-link,/${LIBSDIR} -isystem /usr/include" \
        $HDSRCDIR/$DIR/configure $CONF || return 1
    ;;
    Tools)
      CC="$CC $BUILD" CXX="$CXX $BUILD" $HDSRCDIR/$DIR/configure $CONF || return 1
    ;;
    CrossToolsStatic|CrossTools)
      AR=ar LDFLAGS="-Wl,-rpath,/RBS-Cross-Tools/lib" $HDSRCDIR/$DIR/configure $CONF || return 1
    ;;
  esac
  
  case $1 in
    Standard)
      make || return 1
      mkdir -p $TMPROOT/$LIBSDIR
      make install DESTDIR=$TMPROOT || return 1
      ln -sfn ../usr/bin/cpp $TMPROOT/$LIBSDIR/ || return 1
      ln -sfn gcc $TMPROOT/usr/bin/cc || return 1
    ;;
    CrossToolsStatic)
      make all-gcc all-target-libgcc || return 1
      make install-gcc install-target-libgcc || return 1
    ;;
    CrossTools)
      make AS_FOR_TARGET="${BUILDTARGET}-as" LD_FOR_TARGET="${BUILDTARGET}-ld" || return 1
      make install || return 1
      F=/RBS-Cross-Tools/$BUILDTARGET/lib/libgcc_s.so.1
      if [ -e "$F" ]; then
        ln -sfn $F /RBS-Tools/lib/ || return 1
      fi
      F=/RBS-Cross-Tools/$BUILDTARGET/lib64/libgcc_s.so.1
      if [ -e "$F" ]; then
        ln -sfn $F /RBS-Tools/lib64/ || return 1
      fi
    ;;
    Tools)
      sed -i "/^HOST_\(GMP\|PPL\|CLOOG\)\(LIBS\|INC\)/s:-[IL]/\(lib\|include\)::" Makefile || return 1
      make AS_FOR_TARGET="${AS}" LD_FOR_TARGET="${LD}" || return 1
      make install || return 1
    ;;
  esac
  
  case $1 in
    CrossToolsStatic)
      find /RBS-Cross-Tools/ -name 'libgcc.a' -exec dirname {} \; | while read x; do
        ln -sfn libgcc.a $x/libgcc_eh.a || return 1
      done
    ;;
  esac
  
  cd ../ || return 1
  rm -rf gcc-build || return 1
  cd $HDSRCDIR || return 1
  rm -rf $DIR || return 1
}

RBS_Cross_Tools_BuildStatic(){
  My_GCC_MultiBuild_Func CrossToolsStatic || return 1
  return 0
}

RBS_Cross_Tools_Build(){
  My_GCC_MultiBuild_Func CrossTools || return 1
  return 0
}

RBS_Tools_Build(){
  My_GCC_MultiBuild_Func Tools || return 1
  return 0
}

build(){
  My_GCC_MultiBuild_Func Standard || return 1
  return 0
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gcc/gcc-%version%/'
  VERSION_STRING='gcc-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gcc/gcc-%version%/gcc-%version%.tar.bz2'
  )
}

