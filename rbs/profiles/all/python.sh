#!/bin/bash

VERSION="2.6.5"

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
6bef0417e71a1a1737ccf5750420fdb3
)

rbs_do_python_patching(){

cat << "EOF" | patch -Np1 || return 1
diff -Naur Python-2.6/Lib/distutils/command/install.py Python-2.6.patched/Lib/distutils/command/install.py
--- Python-2.6/Lib/distutils/command/install.py	2008-05-06 18:41:46.000000000 -0400
+++ Python-2.6.patched/Lib/distutils/command/install.py	2008-10-25 18:48:59.000000000 -0400
@@ -42,14 +42,14 @@
 INSTALL_SCHEMES = {
     'unix_prefix': {
         'purelib': '$base/lib/python$py_version_short/site-packages',
-        'platlib': '$platbase/lib/python$py_version_short/site-packages',
+        'platlib': '$platbase/@@MULTILIB_DIR@@/python$py_version_short/site-packages',
         'headers': '$base/include/python$py_version_short/$dist_name',
         'scripts': '$base/bin',
         'data'   : '$base',
         },
     'unix_home': {
         'purelib': '$base/lib/python',
-        'platlib': '$base/lib/python',
+        'platlib': '$base/@@MULTILIB_DIR@@/python',
         'headers': '$base/include/python/$dist_name',
         'scripts': '$base/bin',
         'data'   : '$base',
diff -Naur Python-2.6/Lib/distutils/sysconfig.py Python-2.6.patched/Lib/distutils/sysconfig.py
--- Python-2.6/Lib/distutils/sysconfig.py	2008-06-05 08:58:24.000000000 -0400
+++ Python-2.6.patched/Lib/distutils/sysconfig.py	2008-10-25 18:52:11.000000000 -0400
@@ -113,10 +113,13 @@
     """
     if prefix is None:
         prefix = plat_specific and EXEC_PREFIX or PREFIX
-
+        if plat_specific or standard_lib:
+            lib = "@@MULTILIB_DIR@@"
+        else:
+            lib = "lib"
     if os.name == "posix":
         libpython = os.path.join(prefix,
-                                 "lib", "python" + get_python_version())
+                                 "@@MULTILIB_DIR@@", "python" + get_python_version())
         if standard_lib:
             return libpython
         else:
diff -Naur Python-2.6/Lib/site.py Python-2.6.patched/Lib/site.py
--- Python-2.6/Lib/site.py	2008-05-10 13:36:24.000000000 -0400
+++ Python-2.6.patched/Lib/site.py	2008-10-25 19:01:04.000000000 -0400
@@ -265,9 +265,14 @@
         if sys.platform in ('os2emx', 'riscos'):
             sitedirs.append(os.path.join(prefix, "Lib", "site-packages"))
         elif os.sep == '/':
+            sitedirs.append(os.path.join(prefix, "@@MULTILIB_DIR@@",
+                                        "python" + sys.version[:3],
+                                        "site-packages"))
             sitedirs.append(os.path.join(prefix, "lib",
                                         "python" + sys.version[:3],
                                         "site-packages"))
+            sitedirs.append(os.path.join(prefix, "@@MULTILIB_DIR@@",
+                                        "site-python"))
             sitedirs.append(os.path.join(prefix, "lib", "site-python"))
         else:
             sitedirs.append(prefix)
diff -Naur Python-2.6/Makefile.pre.in Python-2.6.patched/Makefile.pre.in
--- Python-2.6/Makefile.pre.in	2008-09-05 18:59:17.000000000 -0400
+++ Python-2.6.patched/Makefile.pre.in	2008-10-25 19:03:45.000000000 -0400
@@ -87,11 +87,11 @@
 
 # Expanded directories
 BINDIR=		$(exec_prefix)/bin
-LIBDIR=		$(exec_prefix)/lib
+LIBDIR=		$(exec_prefix)/@@MULTILIB_DIR@@
 MANDIR=		@mandir@
 INCLUDEDIR=	@includedir@
 CONFINCLUDEDIR=	$(exec_prefix)/include
-SCRIPTDIR=	$(prefix)/lib
+SCRIPTDIR=	$(prefix)/@@MULTILIB_DIR@@
 
 # Detailed destination directories
 BINLIBDEST=	$(LIBDIR)/python$(VERSION)
diff -Naur Python-2.6/Modules/Setup.dist Python-2.6.patched/Modules/Setup.dist
--- Python-2.6/Modules/Setup.dist	2008-09-21 03:31:52.000000000 -0400
+++ Python-2.6.patched/Modules/Setup.dist	2008-10-25 19:08:07.000000000 -0400
@@ -338,7 +338,7 @@
 # *** Uncomment and edit to reflect your Tcl/Tk versions:
 #	-ltk8.2 -ltcl8.2 \
 # *** Uncomment and edit to reflect where your X11 libraries are:
-#	-L/usr/X11R6/lib \
+# 	-L/usr/X11R6/@@MULTILIB_DIR@@ \
 # *** Or uncomment this for Solaris:
 #	-L/usr/openwin/lib \
 # *** Uncomment these for TOGL extension only:
@@ -409,7 +409,7 @@
 #DB=/usr/local/BerkeleyDB.4.0
 #DBLIBVER=4.0
 #DBINC=$(DB)/include
-#DBLIB=$(DB)/lib
+DBLIB=$(DB)/@@MULTILIB_DIR@@
 #_bsddb _bsddb.c -I$(DBINC) -L$(DBLIB) -ldb-$(DBLIBVER)
 
 # Historical Berkeley DB 1.85
@@ -455,7 +455,7 @@
 # Andrew Kuchling's zlib module.
 # This require zlib 1.1.3 (or later).
 # See http://www.gzip.org/zlib/
-#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz
+#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/@@MULTILIB_DIR@@ -lz
 
 # Interface to the Expat XML parser
 #
diff -Naur Python-2.6/Modules/getpath.c Python-2.6.patched/Modules/getpath.c
--- Python-2.6/Modules/getpath.c	2007-03-10 02:38:14.000000000 -0500
+++ Python-2.6.patched/Modules/getpath.c	2008-10-25 19:06:10.000000000 -0400
@@ -117,8 +117,8 @@
 #endif
 
 #ifndef PYTHONPATH
-#define PYTHONPATH PREFIX "/lib/python" VERSION ":" \
-              EXEC_PREFIX "/lib/python" VERSION "/lib-dynload"
+#define PYTHONPATH PREFIX "/@@MULTILIB_DIR@@/python" VERSION ":" \
+              EXEC_PREFIX "/@@MULTILIB_DIR@@/python" VERSION "/lib-dynload"
 #endif
 
 #ifndef LANDMARK
@@ -129,7 +129,7 @@
 static char exec_prefix[MAXPATHLEN+1];
 static char progpath[MAXPATHLEN+1];
 static char *module_search_path = NULL;
-static char lib_python[] = "lib/python" VERSION;
+static char lib_python[] = "@@MULTILIB_DIR@@/python" VERSION;
 
 static void
 reduce(char *dir)
@@ -524,7 +524,7 @@
     }
     else
         strncpy(zip_path, PREFIX, MAXPATHLEN);
-    joinpath(zip_path, "lib/python00.zip");
+    joinpath(zip_path, "@@MULTILIB_DIR@@/python00.zip");
     bufsz = strlen(zip_path);	/* Replace "00" with version */
     zip_path[bufsz - 6] = VERSION[0];
     zip_path[bufsz - 5] = VERSION[2];
@@ -534,7 +534,7 @@
             fprintf(stderr,
                 "Could not find platform dependent libraries <exec_prefix>\n");
         strncpy(exec_prefix, EXEC_PREFIX, MAXPATHLEN);
-        joinpath(exec_prefix, "lib/lib-dynload");
+        joinpath(exec_prefix, "@@MULTILIB_DIR@@/lib-dynload");
     }
     /* If we found EXEC_PREFIX do *not* reduce it!  (Yet.) */
 
diff -Naur Python-2.6/setup.py Python-2.6.patched/setup.py
--- Python-2.6/setup.py	2008-09-29 20:15:45.000000000 -0400
+++ Python-2.6.patched/setup.py	2008-10-25 19:14:57.000000000 -0400
@@ -310,7 +310,7 @@
 
     def detect_modules(self):
         # Ensure that /usr/local is always used
-        add_dir_to_list(self.compiler.library_dirs, '/usr/local/lib')
+        add_dir_to_list(self.compiler.library_dirs, '/usr/local/@@MULTILIB_DIR@@')
         add_dir_to_list(self.compiler.include_dirs, '/usr/local/include')
 
         # Add paths specified in the environment variables LDFLAGS and
@@ -361,7 +361,7 @@
         # if a file is found in one of those directories, it can
         # be assumed that no additional -I,-L directives are needed.
         lib_dirs = self.compiler.library_dirs + [
-            '/lib64', '/usr/lib64',
+            '/@@MULTILIB_DIR@@', '/usr/@@MULTILIB_DIR@@',
             '/lib', '/usr/lib',
             ]
         inc_dirs = self.compiler.include_dirs + ['/usr/include']
@@ -583,11 +583,11 @@
             elif self.compiler.find_library_file(lib_dirs, 'curses'):
                 readline_libs.append('curses')
             elif self.compiler.find_library_file(lib_dirs +
-                                               ['/usr/lib/termcap'],
+                                               ['/usr/@@MULTILIB_DIR@@/termcap'],
                                                'termcap'):
                 readline_libs.append('termcap')
             exts.append( Extension('readline', ['readline.c'],
-                                   library_dirs=['/usr/lib/termcap'],
+                                   library_dirs=['/usr/@@MULTILIB_DIR@@/termcap'],
                                    extra_link_args=readline_extra_link_args,
                                    libraries=readline_libs) )
         else:
@@ -624,8 +624,8 @@
             if krb5_h:
                 ssl_incs += krb5_h
         ssl_libs = find_library_file(self.compiler, 'ssl',lib_dirs,
-                                     ['/usr/local/ssl/lib',
-                                      '/usr/contrib/ssl/lib/'
+                                     ['/usr/local/ssl/@@MULTILIB_DIR@@',
+                                      '/usr/contrib/ssl/@@MULTILIB_DIR@@/'
                                      ] )
 
         if (ssl_incs is not None and
@@ -836,7 +836,7 @@
 
                 # check lib directories parallel to the location of the header
                 db_dirs_to_check = [
-                    db_incdir.replace("include", 'lib64'),
+                    db_incdir.replace("include", '@@MULTILIB_DIR@@'),
                     db_incdir.replace("include", 'lib'),
                 ]
                 db_dirs_to_check = filter(os.path.isdir, db_dirs_to_check)
@@ -927,9 +927,9 @@
 
         if sqlite_incdir:
             sqlite_dirs_to_check = [
-                os.path.join(sqlite_incdir, '..', 'lib64'),
+                os.path.join(sqlite_incdir, '..', '@@MULTILIB_DIR@@'),
                 os.path.join(sqlite_incdir, '..', 'lib'),
-                os.path.join(sqlite_incdir, '..', '..', 'lib64'),
+                os.path.join(sqlite_incdir, '..', '..', '@@MULTILIB_DIR@@'),
                 os.path.join(sqlite_incdir, '..', '..', 'lib'),
             ]
             sqlite_libfile = self.compiler.find_library_file(
@@ -1562,7 +1562,7 @@
             added_lib_dirs.append('/usr/openwin/lib')
         elif os.path.exists('/usr/X11R6/include'):
             include_dirs.append('/usr/X11R6/include')
-            added_lib_dirs.append('/usr/X11R6/lib64')
+            added_lib_dirs.append('/usr/X11R6/@@MULTILIB_DIR@@')
             added_lib_dirs.append('/usr/X11R6/lib')
         elif os.path.exists('/usr/X11R5/include'):
             include_dirs.append('/usr/X11R5/include')
EOF

}

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  rbs_do_python_patching || return 1
  sed -i -e "s:@@MULTILIB_DIR@@:$LIBSDIR:g" \
    Lib/distutils/command/install.py \
    Lib/distutils/sysconfig.py \
    Lib/site.py \
    Makefile.pre.in \
    Modules/Setup.dist \
    Modules/getpath.c \
    setup.py || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=$TCDIR \
    --libdir=$TCDIR/$LIBSDIR --enable-shared || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  rbs_do_python_patching || return 1
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
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://www.python.org/ftp/python/%version%/Python-%version%.tar.bz2'
  )
}
