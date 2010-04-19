#!/bin/bash

DISABLE_MULTILIB=1

VERSION="16.0"

DIR="hwinfo-${VERSION}"
TARBALL="hwinfo_${VERSION}.orig.tar.gz"

DEPENDS=(
  hal
)

SRC1=(
http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/${TARBALL}
)

MD5SUMS=(
b7e5cae47a373b75abd5a4a5f7584b98
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
cat << "EOF" | patch -Np1 || return 1
diff -Naur hwinfo-15.3/src/int10/i10_v86.c hwinfo-15.3.patched/src/int10/i10_v86.c
--- hwinfo-15.3/src/int10/i10_v86.c	2005-04-01 05:19:13.000000000 -0500
+++ hwinfo-15.3.patched/src/int10/i10_v86.c	2009-06-12 06:57:25.000000000 -0400
@@ -27,6 +27,13 @@
 #include <string.h>
 #ifdef __i386__
 #include <sys/vm86.h>
+  #if defined(__linux__) && !defined(TF_MASK)
+        #define TF_MASK X86_EFLAGS_TF
+        #define IF_MASK X86_EFLAGS_IF
+        #define NT_MASK X86_EFLAGS_NT
+        #define VIF_MASK X86_EFLAGS_VIF
+        #define VIP_MASK X86_EFLAGS_VIP
+  #endif
 #else
 #include "vm86_struct.h"
 #endif
diff -Naur hwinfo-14.19/src/hd/kbd.c hwinfo-14.19.patched/src/hd/kbd.c
--- hwinfo-14.19/src/hd/kbd.c	2007-08-15 06:26:10.000000000 -0400
+++ hwinfo-14.19.patched/src/hd/kbd.c	2008-07-05 20:30:04.000000000 -0400
@@ -142,11 +142,15 @@
   }
 
   if(!dev && (fd = open(DEV_CONSOLE, O_RDWR | O_NONBLOCK | O_NOCTTY)) >= 0) {
+  
+/* Removing TIOCGDEV as it is SUSE-specific
+
+  
     if(ioctl(fd, TIOCGDEV, &u) != -1) {
       tty_major = (u >> 8) & 0xfff;
       tty_minor = (u & 0xff) | ((u >> 12) & 0xfff00);
       ADD2LOG(DEV_CONSOLE ": major %u, minor %u\n", tty_major, tty_minor);
-    }
+    }*/
 
     if (0)
 	    ;
EOF
  
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install LIBDIR=/usr/$LIBSDIR DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/'
  VERSION_STRING='hwinfo_%version%.orig.tar.gz'
  MIRRORS=(
    'http://li.archive.ubuntu.com/ubuntu/pool/universe/h/hwinfo/hwinfo_%version%.orig.tar.gz'
  )
}
