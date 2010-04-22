#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.11.23"

DIR="cvs-${VERSION}"
TARBALL="cvs-${VERSION}.tar.bz2"

DEPENDS=(
  nano
)

SRC1=(
http://ftp.gnu.org/non-gnu/cvs/source/stable/$VERSION/${TARBALL}
)

MD5SUMS=(
0213ea514e231559d6ff8f80a34117f0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
cat << "EOF" | patch -Np1 || return 1
diff -Naur cvs-1.11.23/lib/getline.c cvs-1.11.23.patched/lib/getline.c
--- cvs-1.11.23/lib/getline.c	2005-04-04 16:46:05.000000000 -0400
+++ cvs-1.11.23.patched/lib/getline.c	2009-07-11 22:06:49.000000000 -0400
@@ -155,7 +155,7 @@
 }
 
 int
-getline (lineptr, n, stream)
+_getline (lineptr, n, stream)
      char **lineptr;
      size_t *n;
      FILE *stream;
diff -Naur cvs-1.11.23/lib/getline.h cvs-1.11.23.patched/lib/getline.h
--- cvs-1.11.23/lib/getline.h	2005-04-04 16:46:05.000000000 -0400
+++ cvs-1.11.23.patched/lib/getline.h	2009-07-11 22:06:15.000000000 -0400
@@ -12,7 +12,7 @@
 #define GETLINE_NO_LIMIT -1
 
 int
-  getline __PROTO ((char **_lineptr, size_t *_n, FILE *_stream));
+  _getline __PROTO ((char **_lineptr, size_t *_n, FILE *_stream));
 int
   getline_safe __PROTO ((char **_lineptr, size_t *_n, FILE *_stream,
                          int limit));
EOF

  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/non-gnu/cvs/source/stable/%version%/'
  VERSION_STRING='cvs-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/non-gnu/cvs/source/stable/%version%/cvs-%version%.tar.bz2'
  )
}
