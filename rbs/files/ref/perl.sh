#!/bin/bash

#### 5.12.0 compile error
#
#  make[1]: Entering directory `/usr/src/rbs/.work/source/perl-5.12.0/ext/Errno'
#  ../../miniperl "-I../../lib" "-I../../lib" Errno_pm.PL Errno.pm
#  No error definitions found at Errno_pm.PL line 228.
#  make[1]: *** [Errno.pm] Error 2
#  make[1]: Leaving directory `/usr/src/rbs/.work/source/perl-5.12.0/ext/Errno'
#  Unsuccessful make(ext/Errno): code=512 at make_ext.pl line 449.
#  make: *** [ext/Errno/pm_to_blib] Error 25
#
####

VERSION="5.10.1"

DIR="perl-${VERSION}"
TARBALL="perl-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.funet.fi/pub/CPAN/src/${TARBALL}
)

MD5SUMS=(
b9b2fdb957f50ada62d73f43ee75d044
)


rbs_do_perl_patching(){

cat << "EOF" | patch -Np1 || return 1
diff -Naur perl-5.12.0/Configure perl-5.12.0.patched/Configure
--- perl-5.12.0/Configure	2010-02-18 13:53:53.000000000 -0500
+++ perl-5.12.0.patched/Configure	2010-04-15 14:14:09.000000000 -0400
@@ -6254,6 +6254,7 @@
 : The default "style" setting is made in installstyle.U
 case "$installstyle" in
 *lib/perl5*) set dflt privlib lib/$package/$version ;;
+*lib64/perl5*) set dflt privlib lib64/$package/$version ;;
 *)	 set dflt privlib lib/$version ;;
 esac
 eval $prefixit
@@ -6502,6 +6503,7 @@
 case "$sitelib" in
 '') case "$installstyle" in
 	*lib/perl5*) dflt=$siteprefix/lib/$package/site_$prog/$version ;;
+	*lib64/perl5*) dflt=$siteprefix/lib64/$package/site_$prog/$version ;;
 	*)	 dflt=$siteprefix/lib/site_$prog/$version ;;
 	esac
 	;;
@@ -7020,6 +7022,7 @@
 		prog=`echo $package | $sed 's/-*[0-9.]*$//'`
 		case "$installstyle" in
 		*lib/perl5*) dflt=$vendorprefix/lib/$package/vendor_$prog/$version ;;
+		*lib64/perl5*) dflt=$vendorprefix/lib64/$package/vendor_$prog/$version ;;
 		*)	     dflt=$vendorprefix/lib/vendor_$prog/$version ;;
 		esac
 		;;
diff -Naur perl-5.12.0/hints/linux.sh perl-5.12.0.patched/hints/linux.sh
--- perl-5.12.0/hints/linux.sh	2010-01-18 13:52:49.000000000 -0500
+++ perl-5.12.0.patched/hints/linux.sh	2010-04-15 14:08:54.000000000 -0400
@@ -63,9 +63,9 @@
 # We don't use __GLIBC__ and  __GLIBC_MINOR__ because they
 # are insufficiently precise to distinguish things like
 # libc-2.0.6 and libc-2.0.7.
-if test -L /lib/libc.so.6; then
-    libc=`ls -l /lib/libc.so.6 | awk '{print $NF}'`
-    libc=/lib/$libc
+if test -L ${prefix}/lib/libc.so.6; then
+    libc=`ls -l ${prefix}/lib/libc.so.6 | awk '{print $NF}'`
+    libc=${prefix}/lib/$libc
 fi
 
 # Configure may fail to find lstat() since it's a static/inline
@@ -441,3 +441,8 @@
     libswanted="$libswanted pthread"
     ;;
 esac
+
+locincpth=""
+loclibpth=""
+glibpth="${prefix}/lib"
+usrinc="${prefix}/include"
EOF

}


RBS_Tools_Build(){
  local MYBUILD MYLIBSDIR
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  rbs_do_perl_patching || return 1
  MYBUILD=$BUILD
  MYLIBSDIR=$LIBSDIR
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    MYBUILD=$BUILD32
    MYLIBSDIR=$LIBSDIR32
  fi
  sed -i "/libc/s@/lib@/${MYLIBSDIR}@" hints/linux.sh || return 1
  echo 'installstyle="${MYLIBSDIR}/perl5"' >> hints/linux.sh || return 1
  CC="$CC $MYBUILD" CXX="$CXX $MYBUILD" ./configure.gnu --prefix=/RBS-Tools \
    -Dstatic_ext='Data/Dumper IO Fcntl POSIX' \
    -Dlibpth="/RBS-Tools/$MYLIBSDIR" \
    -Dcc="$CC $MYBUILD" || return 1
  make perl utilities || return 1
  cp -v perl pod/pod2man /RBS-Tools/bin || return 1
  install -dv /RBS-Tools/$MYLIBSDIR/site_perl/$VERSION || return 1
  cp -Rv lib/* /RBS-Tools/$MYLIBSDIR/site_perl/$VERSION || return 1
  ln -sfnv /RBS-Tools/bin/perl /usr/bin/ || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  rbs_do_perl_patching || return 1
  sed -i -e "s@pldlflags=''@pldlflags=\"\$cccdlflags\"@g" \
    -e "s@static_target='static'@static_target='static_pic'@g" \
     Makefile.SH || return 1
  sed -i "/libc/s@/lib@/${LIBSDIR}@" hints/linux.sh || return 1
  echo 'installstyle="${LIBSDIR}/perl5"' >> hints/linux.sh || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure.gnu --prefix=/usr \
    -Dvendorprefix=/usr \
    -Dman1dir=/usr/share/man/man1 \
    -Dman3dir=/usr/share/man/man3 \
    -Dpager="/bin/less -isR" \
    -Dlibpth="/usr/local/$LIBSDIR /$LIBSDIR /usr/$LIBSDIR" \
    -Dcc="$CC $BUILD" \
    -Dusethreads -Duseshrplib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/perl{,${VERSION}} || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.funet.fi/pub/CPAN/src/'
  VERSION_STRING='perl-%version%.tar.gz'
  VERSION_FILTERS="RC"
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.funet.fi/pub/CPAN/src/perl-%version%.tar.gz'
  )
}
