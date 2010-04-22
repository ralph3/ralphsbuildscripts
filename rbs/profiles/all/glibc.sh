#!/bin/bash

VERSION="2.11.1"

DIR="glibc-${VERSION}"
TARBALL="glibc-${VERSION}.tar.bz2"

DEPENDS=(
  linux-headers
)

SRC1=(
http://ftp.gnu.org/gnu/glibc/$TARBALL
)

MD5SUMS=(
6856d5d8b1239556687f0d1217f3f266
)

#my_src1(){
#  cvs -z3 -d :pserver:anoncvs:anoncvs@sources.redhat.com:/cvs/glibc \
#    export -r glibc-$(echo $VERSION | tr "." "_") -d $DIR libc || return 1
#}


rbs_do_glibc_patching(){

cat << "EOF" | patch -Np1 || return 1
diff -Naur glibc-2.11.1/nptl/sysdeps/pthread/pt-initfini.c glibc-2.11.1.patched/nptl/sysdeps/pthread/pt-initfini.c
--- glibc-2.11.1/nptl/sysdeps/pthread/pt-initfini.c	2009-12-08 15:10:20.000000000 -0500
+++ glibc-2.11.1.patched/nptl/sysdeps/pthread/pt-initfini.c	2010-04-14 21:01:50.000000000 -0400
@@ -45,6 +45,11 @@
 /* Embed an #include to pull in the alignment and .end directives. */
 asm ("\n#include \"defs.h\"");
 
+asm ("\n#if defined __i686 && defined __ASSEMBLER__");
+asm ("\n#undef __i686");
+asm ("\n#define __i686 __i686");
+asm ("\n#endif");
+
 /* The initial common code ends here. */
 asm ("\n/*@HEADER_ENDS*/");
 
diff -Naur glibc-2.11.1/sysdeps/unix/sysv/linux/i386/sysdep.h glibc-2.11.1.patched/sysdeps/unix/sysv/linux/i386/sysdep.h
--- glibc-2.11.1/sysdeps/unix/sysv/linux/i386/sysdep.h	2009-12-08 15:10:20.000000000 -0500
+++ glibc-2.11.1.patched/sysdeps/unix/sysv/linux/i386/sysdep.h	2010-04-14 21:00:51.000000000 -0400
@@ -29,6 +29,10 @@
 #include <dl-sysdep.h>
 #include <tls.h>
 
+#if defined __i686 && defined __ASSEMBLER__
+#undef __i686
+#define __i686 __i686
+#endif
 
 /* For Linux we can use the system call table in the header file
 	/usr/include/asm/unistd.h
EOF

}

Cross_Tools_Build(){
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
  rbs_do_glibc_patching || return 1
  mkdir -p $SRCDIR/glibc-build || return 1
  cd $SRCDIR/glibc-build || return 1
  echo "slibdir=$TCDIR/$LIBSDIR" > configparms
  echo "libc_cv_forced_unwind=yes" > config.cache
  echo "libc_cv_c_cleanup=yes" >> config.cache
  if [ "$DOCRAP" == "1" ]; then
    echo "libc_cv_386_tls=yes" >> config.cache
  fi
  LD_LIBRARY_PATH= BUILD_CC="gcc" CC="${BUILDTARGET}-gcc $BUILD" \
    CXX="${BUILDTARGET}-g++ $BUILD" CFLAGS="$XFLAGS -O2 -fgnu89-inline" \
    ../$DIR/configure --prefix=$TCDIR --host=$GLIBC_TARGETHOST \
    --build=$BUILDHOST --libdir=$TCDIR/$LIBSDIR --disable-profile \
    --enable-add-ons --with-tls --enable-kernel=2.6.33 --with-__thread \
    --with-binutils=$CTCDIR/bin --with-headers=$TCDIR/include \
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
      CFLAGS="-march=$($CC -dumpmachine | cut -f1 -d'-') -O2"
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
  cd $SRCDIR/$DIR || return 1
  
  rbs_do_glibc_patching || return 1
  
  mkdir -p $SRCDIR/glibc-build || return 1
  cd $SRCDIR/glibc-build || return 1
  echo "slibdir=/$LIBSDIR" > configparms
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ../$DIR/configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR --disable-profile --enable-add-ons \
    --enable-kernel=2.6.33 --with-__thread \
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
  
  echo > $TMPROOT/etc/resolv.conf.tmpnew || return 1
  
  echo '127.0.0.1 localhost.localdomain localhost' > $TMPROOT/etc/hosts.tmpnew || return 1
  
cat > $TMPROOT/etc/nsswitch.conf.tmpnew << "EOF" || return 1
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
  VERSION_FILTERS="ports linuxthreads libidn"
  MIRRORS=(
    'http://ftp.gnu.org/gnu/glibc/glibc-%version%.tar.bz2'
  )
}
