#!/bin/bash

VERSION="0.0.0-20091011"

DIR="glibc-${VERSION}"
TARBALL="glibc-${VERSION}.tar.xz"

DEPENDS=(
  linux-headers
)

#
#SRC1=(
#http://ftp.gnu.org/gnu/glibc/$TARBALL
#)
#
#MD5SUMS=(
#ee71dedf724dc775e4efec9b823ed3be
#)
#

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    svn://svn.eglibc.org/trunk $DIR || return 1
}

RBS_Cross_Tools_Build(){
  local DOCRAP GLIBC_TARGETHOST XFLAGS
  DOCRAP=
  GLIBC_TARGETHOST=$BUILDTARGET
  XFLAGS=
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i486|i586|i686)
      DOCRAP=1
      XFLAGS="-march=i486 -mtune=native"
    ;;
    x86_64)
      case $SYSTYPE in
        MULTILIB)
          if [ "$BUILD" == "$BUILD32" ]; then
            DOCRAP=1
            XFLAGS="-march=i486 -mtune=native"
            GLIBC_TARGETHOST=$BUILDTARGET32
          fi
        ;;
      esac
    ;;
  esac
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  mkdir -p $SRCDIR/glibc-build || return 1
  cd $SRCDIR/glibc-build || return 1
  echo "slibdir=/RBS-Tools/$LIBSDIR" > configparms
  echo "libc_cv_forced_unwind=yes" > config.cache
  echo "libc_cv_c_cleanup=yes" >> config.cache
  if [ "$DOCRAP" == "1" ]; then
    echo "libc_cv_386_tls=yes" >> config.cache
  fi
  LD_LIBRARY_PATH= BUILD_CC="gcc" CC="${BUILDTARGET}-gcc $BUILD" \
    CXX="${BUILDTARGET}-g++ $BUILD" CFLAGS="$XFLAGS -O2 -fgnu89-inline" \
    ../$DIR/configure --prefix=/RBS-Tools --host=$GLIBC_TARGETHOST \
    --build=$BUILDHOST --libdir=/RBS-Tools/$LIBSDIR --disable-profile \
    --enable-add-ons --with-tls --enable-kernel=2.6.0 --with-__thread \
    --with-binutils=/RBS-Cross-Tools/bin --with-headers=/RBS-Tools/include \
    --cache-file=config.cache || return 1
  make LD_LIBRARY_PATH= || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR glibc-build || return 1
}

build(){
  local CONF
  CONF=
  case $($CC -dumpmachine | cut -f1 -d'-') in
    i?86)
      CFLAGS="-march=i486 -O2"
    ;;
    x86_64)
      case $SYSTYPE in
        MULTILIB)
          if [ "$BUILD" == "$BUILD32" ]; then
            CONF="--host=${BUILDTARGET32}"
            CFLAGS="-march=i486 -O2"
          fi
        ;;
      esac
    ;;
  esac
  
  CXXFLAGS="$CFLAGS"
  export CFLAGS CXXFLAGS
  
  mkdir -p $SRCDIR || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR glibc-build || return 1
  
  unpack_tarball $TARBALL || return 1
  mkdir -p $SRCDIR/glibc-build || return 1
  cd $SRCDIR/glibc-build || return 1
  echo "slibdir=/$LIBSDIR" > configparms
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ../$DIR/configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR --disable-profile --enable-add-ons \
    --enable-kernel=2.6.0 --with-__thread \
    --libexecdir=/usr/$LIBSDIR/glibc || return 1
  make || return 1
  make install_root=$TMPROOT install || return 1
  mkdir -p $TMPROOT/usr/$LIBSDIR/locale $TMPROOT/etc/ld.so.conf.d || return 1
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i486|i586|i686)
cat << EOF > $TMPROOT/etc/ld.so.conf.d/glibc.conf
/lib
/usr/lib
EOF
    ;;
    x86_64)
      case $SYSTYPE in
        64BIT)
cat << "EOF" > $TMPROOT/etc/ld.so.conf.d/glibc.conf
/lib64
/usr/lib64
EOF
        ;;
        MULTILIB)
cat << "EOF" > $TMPROOT/etc/ld.so.conf.d/glibc.conf
/lib64
/usr/lib64
/lib
/usr/lib
EOF
        ;;
      esac
    ;;
  esac
  rm -f $TMPROOT/etc/{localtime,ld.so.cache}
  
  echo 'include /etc/ld.so.conf.d/*.conf' > $TMPROOT/etc/ld.so.conf
  
  echo > $TMPROOT/etc/resolv.conf.tmpnew
  
cat > $TMPROOT/etc/nsswitch.conf.tmpnew << "EOF"
passwd: files
group: files
shadow: files
hosts: files dns
networks: files
protocols: files
services: files
ethers: files
rpc: files
EOF
  
  if [ -e "$TMPROOT/usr/share/zoneinfo/UTC" ]; then
    cp $TMPROOT/usr/share/zoneinfo/UTC $TMPROOT/etc/localtime.tmpnew || return 1
  fi
  
  cd $SRCDIR || return 1
  rm -rf $DIR glibc-build || return 1
}

post_install(){
  localedef -i en_US -f ISO-8859-1 en_US
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/glibc/'
  VERSION_STRING='glibc-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/glibc/glibc-%version%.tar.bz2'
  )
}
