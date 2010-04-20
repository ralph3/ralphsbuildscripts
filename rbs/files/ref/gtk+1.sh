#!/bin/bash

VERSION="1.2.10"

DIR="gtk+-1.2.10"
TARBALL="gtk+-1.2.10.tar.gz"

DEPENDS=(
  glib1
)

SRC1=(
ftp://ftp.gtk.org/pub/gtk/v1.2/gtk+-1.2.10.tar.gz
)

MD5SUMS=(
4d5cb2fc7fb7830e4af9747a36bfce20
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1

cat << "RALPHSBUILD" | patch -Np1 || return 1
Submitted By: Jim Gifford (jim at linuxfromscratch dot org)
Date: 2006-07-13
Initial Package Version: 1.2.10
Origin: Gentoo
Upstream Status: Unknown
Description: Various Fixes

diff -Naur gtk+-1.2.10.orig/configure gtk+-1.2.10/configure
--- gtk+-1.2.10.orig/configure	2001-03-28 13:11:45.000000000 -0800
+++ gtk+-1.2.10/configure	2006-07-13 22:47:33.000000000 -0700
@@ -5388,6 +5388,8 @@
 
 # Checks for libraries.
 # Check for the X11 library
+ac_save_LDFLAGS="$LDFLAGS"
+test -n "$x_libraries" && LDFLAGS="$LDFLAGS -L$x_libraries"
 echo $ac_n "checking for XOpenDisplay in -lX11""... $ac_c" 1>&6
 echo "configure:5393: checking for XOpenDisplay in -lX11" >&5
 ac_lib_var=`echo X11'_'XOpenDisplay | sed 'y%./+-%__p_%'`
diff -Naur gtk+-1.2.10.orig/gtk.m4 gtk+-1.2.10/gtk.m4
--- gtk+-1.2.10.orig/gtk.m4	1999-02-18 08:43:35.000000000 -0800
+++ gtk+-1.2.10/gtk.m4	2006-07-13 22:48:39.000000000 -0700
@@ -4,7 +4,7 @@
 dnl AM_PATH_GTK([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND [, MODULES]]]])
 dnl Test for GTK, and define GTK_CFLAGS and GTK_LIBS
 dnl
-AC_DEFUN(AM_PATH_GTK,
+AC_DEFUN([AM_PATH_GTK],
 [dnl 
 dnl Get the cflags and libraries from the gtk-config script
 dnl
RALPHSBUILD

cat << "RALPHSBUILD" | patch -Np1 || return 1
Submitted By: Joe Ciccone <jciccone@linuxfromscratch.org>
Date: 2006-06-26
Initial Package Version: 1.2.10
Upstream Status: Unknown
Origin: Ryan Oliver
Description: Updates config.guess and config.sub to support newer archs.

diff -uNr gtk+-1.2.10-orig/config.guess gtk+-1.2.10/config.guess
--- gtk+-1.2.10-orig/config.guess	2000-02-03 12:07:42.000000000 +1100
+++ gtk+-1.2.10/config.guess	2005-01-27 01:12:54.606002105 +1100
@@ -1,8 +1,10 @@
 #! /bin/sh
 # Attempt to guess a canonical system name.
-#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
 #   Free Software Foundation, Inc.
-#
+
+timestamp='2001-09-04'
+
 # This file is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
@@ -23,51 +25,153 @@
 # the same distribution terms that you use for the rest of that program.
 
 # Written by Per Bothner <bothner@cygnus.com>.
-# The master version of this file is at the FSF in /home/gd/gnu/lib.
-# Please send patches to <autoconf-patches@gnu.org>.
+# Please send patches to <config-patches@gnu.org>.
 #
 # This script attempts to guess a canonical system name similar to
 # config.sub.  If it succeeds, it prints the system name on stdout, and
 # exits with 0.  Otherwise, it exits with 1.
 #
 # The plan is that this can be called by configure scripts if you
-# don't specify an explicit system type (host/target name).
-#
-# Only a few systems have been added to this list; please add others
-# (but try to keep the structure clean).
-#
+# don't specify an explicit build system type.
 
-# Use $HOST_CC if defined. $CC may point to a cross-compiler
-if test x"$CC_FOR_BUILD" = x; then
-  if test x"$HOST_CC" != x; then
-    CC_FOR_BUILD="$HOST_CC"
-  else
-    if test x"$CC" != x; then
-      CC_FOR_BUILD="$CC"
-    else
-      CC_FOR_BUILD=cc
-    fi
-  fi
+me=`echo "$0" | sed -e 's,.*/,,'`
+
+usage="\
+Usage: $0 [OPTION]
+
+Output the configuration name of the system \`$me' is run on.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version="\
+GNU config.guess ($timestamp)
+
+Originally written by Per Bothner.
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
+
+help="
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit 0 ;;
+    --version | -v )
+       echo "$version" ; exit 0 ;;
+    --help | --h* | -h )
+       echo "$usage"; exit 0 ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help" >&2
+       exit 1 ;;
+    * )
+       break ;;
+  esac
+done
+
+if test $# != 0; then
+  echo "$me: too many arguments$help" >&2
+  exit 1
 fi
 
 
+dummy=dummy-$$
+trap 'rm -f $dummy.c $dummy.o $dummy.rel $dummy; exit 1' 1 2 15
+
+# CC_FOR_BUILD -- compiler used by this script.
+# Historically, `CC_FOR_BUILD' used to be named `HOST_CC'. We still
+# use `HOST_CC' if defined, but it is deprecated.
+
+set_cc_for_build='case $CC_FOR_BUILD,$HOST_CC,$CC in
+ ,,)    echo "int dummy(){}" > $dummy.c ;
+	for c in cc gcc c89 ; do
+	  ($c $dummy.c -c -o $dummy.o) >/dev/null 2>&1 ;
+	  if test $? = 0 ; then
+	     CC_FOR_BUILD="$c"; break ;
+	  fi ;
+	done ;
+	rm -f $dummy.c $dummy.o $dummy.rel ;
+	if test x"$CC_FOR_BUILD" = x ; then
+	  CC_FOR_BUILD=no_compiler_found ;
+	fi
+	;;
+ ,,*)   CC_FOR_BUILD=$CC ;;
+ ,*,*)  CC_FOR_BUILD=$HOST_CC ;;
+esac'
+
 # This is needed to find uname on a Pyramid OSx when run in the BSD universe.
-# (ghazi@noc.rutgers.edu 8/24/94.)
+# (ghazi@noc.rutgers.edu 1994-08-24)
 if (test -f /.attbin/uname) >/dev/null 2>&1 ; then
 	PATH=$PATH:/.attbin ; export PATH
 fi
 
 UNAME_MACHINE=`(uname -m) 2>/dev/null` || UNAME_MACHINE=unknown
 UNAME_RELEASE=`(uname -r) 2>/dev/null` || UNAME_RELEASE=unknown
-UNAME_SYSTEM=`(uname -s) 2>/dev/null` || UNAME_SYSTEM=unknown
+UNAME_SYSTEM=`(uname -s) 2>/dev/null`  || UNAME_SYSTEM=unknown
 UNAME_VERSION=`(uname -v) 2>/dev/null` || UNAME_VERSION=unknown
 
-dummy=dummy-$$
-trap 'rm -f $dummy.c $dummy.o $dummy; exit 1' 1 2 15
-
 # Note: order is significant - the case branches are not exclusive.
 
 case "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" in
+    *:NetBSD:*:*)
+	# Netbsd (nbsd) targets should (where applicable) match one or
+	# more of the tupples: *-*-netbsdelf*, *-*-netbsdaout*,
+	# *-*-netbsdecoff* and *-*-netbsd*.  For targets that recently
+	# switched to ELF, *-*-netbsd* would select the old
+	# object file format.  This provides both forward
+	# compatibility and a consistent mechanism for selecting the
+	# object file format.
+	# Determine the machine/vendor (is the vendor relevant).
+	case "${UNAME_MACHINE}" in
+	    amiga) machine=m68k-unknown ;;
+	    arm32) machine=arm-unknown ;;
+	    atari*) machine=m68k-atari ;;
+	    sun3*) machine=m68k-sun ;;
+	    mac68k) machine=m68k-apple ;;
+	    macppc) machine=powerpc-apple ;;
+	    hp3[0-9][05]) machine=m68k-hp ;;
+	    ibmrt|romp-ibm) machine=romp-ibm ;;
+	    *) machine=${UNAME_MACHINE}-unknown ;;
+	esac
+	# The Operating System including object format, if it has switched
+	# to ELF recently, or will in the future.
+	case "${UNAME_MACHINE}" in
+	    i386|sparc|amiga|arm*|hp300|mvme68k|vax|atari|luna68k|mac68k|news68k|next68k|pc532|sun3*|x68k)
+		eval $set_cc_for_build
+		if echo __ELF__ | $CC_FOR_BUILD -E - 2>/dev/null \
+			| grep __ELF__ >/dev/null
+		then
+		    # Once all utilities can be ECOFF (netbsdecoff) or a.out (netbsdaout).
+		    # Return netbsd for either.  FIX?
+		    os=netbsd
+		else
+		    os=netbsdelf
+		fi
+		;;
+	    *)
+	        os=netbsd
+		;;
+	esac
+	# The OS release
+	release=`echo ${UNAME_RELEASE}|sed -e 's/[-_].*/\./'`
+	# Since CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM:
+	# contains redundant information, the shorter form:
+	# CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM is used.
+	echo "${machine}-${os}${release}"
+	exit 0 ;;
     alpha:OSF1:*:*)
 	if test $UNAME_RELEASE = "V4.0"; then
 		UNAME_RELEASE=`/usr/sbin/sizer -v | awk '{print $3}'`
@@ -77,41 +181,55 @@
 	# A Xn.n version is an unreleased experimental baselevel.
 	# 1.2 uses "1.2" for uname -r.
 	cat <<EOF >$dummy.s
+	.data
+\$Lformat:
+	.byte 37,100,45,37,120,10,0	# "%d-%x\n"
+
+	.text
 	.globl main
+	.align 4
 	.ent main
 main:
-	.frame \$30,0,\$26,0
-	.prologue 0
-	.long 0x47e03d80 # implver $0
-	lda \$2,259
-	.long 0x47e20c21 # amask $2,$1
-	srl \$1,8,\$2
-	sll \$2,2,\$2
-	sll \$0,3,\$0
-	addl \$1,\$0,\$0
-	addl \$2,\$0,\$0
-	ret \$31,(\$26),1
+	.frame \$30,16,\$26,0
+	ldgp \$29,0(\$27)
+	.prologue 1
+	.long 0x47e03d80 # implver \$0
+	lda \$2,-1
+	.long 0x47e20c21 # amask \$2,\$1
+	lda \$16,\$Lformat
+	mov \$0,\$17
+	not \$1,\$18
+	jsr \$26,printf
+	ldgp \$29,0(\$26)
+	mov 0,\$16
+	jsr \$26,exit
 	.end main
 EOF
+	eval $set_cc_for_build
 	$CC_FOR_BUILD $dummy.s -o $dummy 2>/dev/null
 	if test "$?" = 0 ; then
-		./$dummy
-		case "$?" in
-			7)
+		case `./$dummy` in
+			0-0)
 				UNAME_MACHINE="alpha"
 				;;
-			15)
+			1-0)
 				UNAME_MACHINE="alphaev5"
 				;;
-			14)
+			1-1)
 				UNAME_MACHINE="alphaev56"
 				;;
-			10)
+			1-101)
 				UNAME_MACHINE="alphapca56"
 				;;
-			16)
+			2-303)
 				UNAME_MACHINE="alphaev6"
 				;;
+			2-307)
+				UNAME_MACHINE="alphaev67"
+				;;
+			2-1307)
+				UNAME_MACHINE="alphaev68"
+				;;
 		esac
 	fi
 	rm -f $dummy.s $dummy
@@ -127,11 +245,8 @@
 	echo alpha-dec-winnt3.5
 	exit 0 ;;
     Amiga*:UNIX_System_V:4.0:*)
-	echo m68k-cbm-sysv4
+	echo m68k-unknown-sysv4
 	exit 0;;
-    amiga:NetBSD:*:*)
-      echo m68k-cbm-netbsd${UNAME_RELEASE}
-      exit 0 ;;
     amiga:OpenBSD:*:*)
 	echo m68k-unknown-openbsd${UNAME_RELEASE}
 	exit 0 ;;
@@ -162,10 +277,7 @@
     arm:RISC*:1.[012]*:*|arm:riscix:1.[012]*:*)
 	echo arm-acorn-riscix${UNAME_RELEASE}
 	exit 0;;
-    arm32:NetBSD:*:*)
-	echo arm-unknown-netbsd`echo ${UNAME_RELEASE}|sed -e 's/[-_].*/\./'`
-	exit 0 ;;
-    SR2?01:HI-UX/MPP:*:*)
+    SR2?01:HI-UX/MPP:*:* | SR8000:HI-UX/MPP:*:*)
 	echo hppa1.1-hitachi-hiuxmpp
 	exit 0;;
     Pyramid*:OSx*:*:* | MIS*:OSx*:*:* | MIS*:SMP_DC-OSx*:*:*)
@@ -221,15 +333,15 @@
     aushp:SunOS:*:*)
 	echo sparc-auspex-sunos${UNAME_RELEASE}
 	exit 0 ;;
-    atari*:NetBSD:*:*)
-	echo m68k-atari-netbsd${UNAME_RELEASE}
+    sparc*:NetBSD:*)
+	echo `uname -p`-unknown-netbsd${UNAME_RELEASE}
 	exit 0 ;;
     atari*:OpenBSD:*:*)
 	echo m68k-unknown-openbsd${UNAME_RELEASE}
 	exit 0 ;;
     # The situation for MiNT is a little confusing.  The machine name
     # can be virtually everything (everything which is not
-    # "atarist" or "atariste" at least should have a processor 
+    # "atarist" or "atariste" at least should have a processor
     # > m68000).  The system name ranges from "MiNT" over "FreeMiNT"
     # to the lowercase version "mint" (or "freemint").  Finally
     # the system name "TOS" denotes a system which is actually not
@@ -253,15 +365,9 @@
     *:*MiNT:*:* | *:*mint:*:* | *:*TOS:*:*)
         echo m68k-unknown-mint${UNAME_RELEASE}
         exit 0 ;;
-    sun3*:NetBSD:*:*)
-	echo m68k-sun-netbsd${UNAME_RELEASE}
-	exit 0 ;;
     sun3*:OpenBSD:*:*)
 	echo m68k-unknown-openbsd${UNAME_RELEASE}
 	exit 0 ;;
-    mac68k:NetBSD:*:*)
-	echo m68k-apple-netbsd${UNAME_RELEASE}
-	exit 0 ;;
     mac68k:OpenBSD:*:*)
 	echo m68k-unknown-openbsd${UNAME_RELEASE}
 	exit 0 ;;
@@ -274,9 +380,6 @@
     powerpc:machten:*:*)
 	echo powerpc-apple-machten${UNAME_RELEASE}
 	exit 0 ;;
-    macppc:NetBSD:*:*)
-        echo powerpc-apple-netbsd${UNAME_RELEASE}
-        exit 0 ;;
     RISC*:Mach:*:*)
 	echo mips-dec-mach_bsd4.3
 	exit 0 ;;
@@ -290,8 +393,10 @@
 	echo clipper-intergraph-clix${UNAME_RELEASE}
 	exit 0 ;;
     mips:*:*:UMIPS | mips:*:*:RISCos)
+	eval $set_cc_for_build
 	sed 's/^	//' << EOF >$dummy.c
 #ifdef __cplusplus
+#include <stdio.h>  /* for printf() prototype */
 	int main (int argc, char *argv[]) {
 #else
 	int main (argc, argv) int argc; char *argv[]; {
@@ -312,10 +417,13 @@
 EOF
 	$CC_FOR_BUILD $dummy.c -o $dummy \
 	  && ./$dummy `echo "${UNAME_RELEASE}" | sed -n 's/\([0-9]*\).*/\1/p'` \
-	  && rm $dummy.c $dummy && exit 0
+	  && rm -f $dummy.c $dummy && exit 0
 	rm -f $dummy.c $dummy
 	echo mips-mips-riscos${UNAME_RELEASE}
 	exit 0 ;;
+    Motorola:PowerMAX_OS:*:*)
+	echo powerpc-motorola-powermax
+	exit 0 ;;
     Night_Hawk:Power_UNIX:*:*)
 	echo powerpc-harris-powerunix
 	exit 0 ;;
@@ -331,7 +439,7 @@
     AViiON:dgux:*:*)
         # DG/UX returns AViiON for all architectures
         UNAME_PROCESSOR=`/usr/bin/uname -p`
-	if [ $UNAME_PROCESSOR = mc88100 ] || [ $UNAME_PROCESSOR = mc88110]
+	if [ $UNAME_PROCESSOR = mc88100 ] || [ $UNAME_PROCESSOR = mc88110 ]
 	then
 	    if [ ${TARGET_BINARY_INTERFACE}x = m88kdguxelfx ] || \
 	       [ ${TARGET_BINARY_INTERFACE}x = x ]
@@ -363,11 +471,20 @@
     ????????:AIX?:[12].1:2)   # AIX 2.2.1 or AIX 2.1.1 is RT/PC AIX.
 	echo romp-ibm-aix      # uname -m gives an 8 hex-code CPU id
 	exit 0 ;;              # Note that: echo "'`uname -s`'" gives 'AIX '
-    i?86:AIX:*:*)
+    i*86:AIX:*:*)
 	echo i386-ibm-aix
 	exit 0 ;;
+    ia64:AIX:*:*)
+	if [ -x /usr/bin/oslevel ] ; then
+		IBM_REV=`/usr/bin/oslevel`
+	else
+		IBM_REV=${UNAME_VERSION}.${UNAME_RELEASE}
+	fi
+	echo ${UNAME_MACHINE}-ibm-aix${IBM_REV}
+	exit 0 ;;
     *:AIX:2:3)
 	if grep bos325 /usr/include/stdio.h >/dev/null 2>&1; then
+		eval $set_cc_for_build
 		sed 's/^		//' << EOF >$dummy.c
 		#include <sys/systemcfg.h>
 
@@ -379,7 +496,7 @@
 			exit(0);
 			}
 EOF
-		$CC_FOR_BUILD $dummy.c -o $dummy && ./$dummy && rm $dummy.c $dummy && exit 0
+		$CC_FOR_BUILD $dummy.c -o $dummy && ./$dummy && rm -f $dummy.c $dummy && exit 0
 		rm -f $dummy.c $dummy
 		echo rs6000-ibm-aix3.2.5
 	elif grep bos324 /usr/include/stdio.h >/dev/null 2>&1; then
@@ -388,9 +505,9 @@
 		echo rs6000-ibm-aix3.2
 	fi
 	exit 0 ;;
-    *:AIX:*:4)
+    *:AIX:*:[45])
 	IBM_CPU_ID=`/usr/sbin/lsdev -C -c processor -S available | head -1 | awk '{ print $1 }'`
-	if /usr/sbin/lsattr -EHl ${IBM_CPU_ID} | grep POWER >/dev/null 2>&1; then
+	if /usr/sbin/lsattr -El ${IBM_CPU_ID} | grep ' POWER' >/dev/null 2>&1; then
 		IBM_ARCH=rs6000
 	else
 		IBM_ARCH=powerpc
@@ -398,7 +515,7 @@
 	if [ -x /usr/bin/oslevel ] ; then
 		IBM_REV=`/usr/bin/oslevel`
 	else
-		IBM_REV=4.${UNAME_RELEASE}
+		IBM_REV=${UNAME_VERSION}.${UNAME_RELEASE}
 	fi
 	echo ${IBM_ARCH}-ibm-aix${IBM_REV}
 	exit 0 ;;
@@ -408,7 +525,7 @@
     ibmrt:4.4BSD:*|romp-ibm:BSD:*)
 	echo romp-ibm-bsd4.4
 	exit 0 ;;
-    ibmrt:*BSD:*|romp-ibm:BSD:*)            # covers RT/PC NetBSD and
+    ibmrt:*BSD:*|romp-ibm:BSD:*)            # covers RT/PC BSD and
 	echo romp-ibm-bsd${UNAME_RELEASE}   # 4.3 with uname added to
 	exit 0 ;;                           # report: romp-ibm BSD 4.3
     *:BOSX:*:*)
@@ -424,11 +541,32 @@
 	echo m68k-hp-bsd4.4
 	exit 0 ;;
     9000/[34678]??:HP-UX:*:*)
+	HPUX_REV=`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
 	case "${UNAME_MACHINE}" in
 	    9000/31? )            HP_ARCH=m68000 ;;
 	    9000/[34]?? )         HP_ARCH=m68k ;;
 	    9000/[678][0-9][0-9])
+              case "${HPUX_REV}" in
+                11.[0-9][0-9])
+                  if [ -x /usr/bin/getconf ]; then
+                    sc_cpu_version=`/usr/bin/getconf SC_CPU_VERSION 2>/dev/null`
+                    sc_kernel_bits=`/usr/bin/getconf SC_KERNEL_BITS 2>/dev/null`
+                    case "${sc_cpu_version}" in
+                      523) HP_ARCH="hppa1.0" ;; # CPU_PA_RISC1_0
+                      528) HP_ARCH="hppa1.1" ;; # CPU_PA_RISC1_1
+                      532)                      # CPU_PA_RISC2_0
+                        case "${sc_kernel_bits}" in
+                          32) HP_ARCH="hppa2.0n" ;;
+                          64) HP_ARCH="hppa2.0w" ;;
+                        esac ;;
+                    esac
+                  fi ;;
+              esac
+              if [ "${HP_ARCH}" = "" ]; then
+	      eval $set_cc_for_build
               sed 's/^              //' << EOF >$dummy.c
+
+              #define _HPUX_SOURCE
               #include <stdlib.h>
               #include <unistd.h>
 
@@ -459,13 +597,19 @@
                   exit (0);
               }
 EOF
-	(CCOPTS= $CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null ) && HP_ARCH=`./$dummy`
-	rm -f $dummy.c $dummy
+	    (CCOPTS= $CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null ) && HP_ARCH=`./$dummy`
+	    if test -z "$HP_ARCH"; then HP_ARCH=hppa; fi
+	    rm -f $dummy.c $dummy
+	fi ;;
 	esac
-	HPUX_REV=`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
 	echo ${HP_ARCH}-hp-hpux${HPUX_REV}
 	exit 0 ;;
+    ia64:HP-UX:*:*)
+	HPUX_REV=`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
+	echo ia64-hp-hpux${HPUX_REV}
+	exit 0 ;;
     3050*:HI-UX:*:*)
+	eval $set_cc_for_build
 	sed 's/^	//' << EOF >$dummy.c
 	#include <unistd.h>
 	int
@@ -491,7 +635,7 @@
 	  exit (0);
 	}
 EOF
-	$CC_FOR_BUILD $dummy.c -o $dummy && ./$dummy && rm $dummy.c $dummy && exit 0
+	$CC_FOR_BUILD $dummy.c -o $dummy && ./$dummy && rm -f $dummy.c $dummy && exit 0
 	rm -f $dummy.c $dummy
 	echo unknown-hitachi-hiuxwe2
 	exit 0 ;;
@@ -501,7 +645,7 @@
     9000/8??:4.3bsd:*:*)
 	echo hppa1.0-hp-bsd
 	exit 0 ;;
-    *9??*:MPE/iX:*:*)
+    *9??*:MPE/iX:*:* | *3000*:MPE/iX:*:*)
 	echo hppa1.0-hp-mpeix
 	exit 0 ;;
     hp7??:OSF1:*:* | hp8?[79]:OSF1:*:* )
@@ -510,7 +654,7 @@
     hp8??:OSF1:*:*)
 	echo hppa1.0-hp-osf
 	exit 0 ;;
-    i?86:OSF1:*:*)
+    i*86:OSF1:*:*)
 	if [ -x /usr/sbin/sysversion ] ; then
 	    echo ${UNAME_MACHINE}-unknown-osf1mk
 	else
@@ -545,37 +689,39 @@
 	echo xmp-cray-unicos
         exit 0 ;;
     CRAY*Y-MP:*:*:*)
-	echo ymp-cray-unicos${UNAME_RELEASE}
+	echo ymp-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
 	exit 0 ;;
     CRAY*[A-Z]90:*:*:*)
 	echo ${UNAME_MACHINE}-cray-unicos${UNAME_RELEASE} \
 	| sed -e 's/CRAY.*\([A-Z]90\)/\1/' \
-	      -e y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/
+	      -e y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/ \
+	      -e 's/\.[^.]*$/.X/'
 	exit 0 ;;
     CRAY*TS:*:*:*)
-	echo t90-cray-unicos${UNAME_RELEASE}
+	echo t90-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*T3D:*:*:*)
+	echo alpha-cray-unicosmk${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
 	exit 0 ;;
     CRAY*T3E:*:*:*)
-	echo alpha-cray-unicosmk${UNAME_RELEASE}
+	echo alphaev5-cray-unicosmk${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*SV1:*:*:*)
+	echo sv1-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
 	exit 0 ;;
     CRAY-2:*:*:*)
 	echo cray2-cray-unicos
         exit 0 ;;
-    F300:UNIX_System_V:*:*)
+    F30[01]:UNIX_System_V:*:* | F700:UNIX_System_V:*:*)
+	FUJITSU_PROC=`uname -m | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`
         FUJITSU_SYS=`uname -p | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz' | sed -e 's/\///'`
         FUJITSU_REL=`echo ${UNAME_RELEASE} | sed -e 's/ /_/'`
-        echo "f300-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
+        echo "${FUJITSU_PROC}-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
         exit 0 ;;
-    F301:UNIX_System_V:*:*)
-       echo f301-fujitsu-uxpv`echo $UNAME_RELEASE | sed 's/ .*//'`
-       exit 0 ;;
-    hp3[0-9][05]:NetBSD:*:*)
-	echo m68k-hp-netbsd${UNAME_RELEASE}
-	exit 0 ;;
     hp300:OpenBSD:*:*)
 	echo m68k-unknown-openbsd${UNAME_RELEASE}
 	exit 0 ;;
-    i?86:BSD/386:*:* | i?86:BSD/OS:*:*)
+    i*86:BSD/386:*:* | i*86:BSD/OS:*:* | *:Ascend\ Embedded/OS:*:*)
 	echo ${UNAME_MACHINE}-pc-bsdi${UNAME_RELEASE}
 	exit 0 ;;
     sparc*:BSD/OS:*:*)
@@ -585,17 +731,8 @@
 	echo ${UNAME_MACHINE}-unknown-bsdi${UNAME_RELEASE}
 	exit 0 ;;
     *:FreeBSD:*:*)
-	if test -x /usr/bin/objformat; then
-	    if test "elf" = "`/usr/bin/objformat`"; then
-		echo ${UNAME_MACHINE}-unknown-freebsdelf`echo ${UNAME_RELEASE}|sed -e 's/[-_].*//'`
-		exit 0
-	    fi
-	fi
 	echo ${UNAME_MACHINE}-unknown-freebsd`echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'`
 	exit 0 ;;
-    *:NetBSD:*:*)
-	echo ${UNAME_MACHINE}-unknown-netbsd`echo ${UNAME_RELEASE}|sed -e 's/[-_].*//'`
-	exit 0 ;;
     *:OpenBSD:*:*)
 	echo ${UNAME_MACHINE}-unknown-openbsd`echo ${UNAME_RELEASE}|sed -e 's/[-_].*/\./'`
 	exit 0 ;;
@@ -605,6 +742,9 @@
     i*:MINGW*:*)
 	echo ${UNAME_MACHINE}-pc-mingw32
 	exit 0 ;;
+    i*:PW*:*)
+	echo ${UNAME_MACHINE}-pc-pw32
+	exit 0 ;;
     i*:Windows_NT*:* | Pentium*:Windows_NT*:*)
 	# How do we know it's Interix rather than the generic POSIX subsystem?
 	# It also conflicts with pre-2.0 versions of AT&T UWIN. Should we
@@ -623,172 +763,99 @@
     *:GNU:*:*)
 	echo `echo ${UNAME_MACHINE}|sed -e 's,[-/].*$,,'`-unknown-gnu`echo ${UNAME_RELEASE}|sed -e 's,/.*$,,'`
 	exit 0 ;;
-    *:Linux:*:*)
-
+    i*86:Minix:*:*)
+	echo ${UNAME_MACHINE}-pc-minix
+	exit 0 ;;
+    arm*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    ia64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux
+	exit 0 ;;
+    m68*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    mips:Linux:*:*)
+	case `sed -n '/^byte/s/^.*: \(.*\) endian/\1/p' < /proc/cpuinfo` in
+	  big)    echo mips-unknown-linux-gnu && exit 0 ;;
+	  little) echo mipsel-unknown-linux-gnu && exit 0 ;;
+	esac
+	;;
+    ppc:Linux:*:*)
+	echo powerpc-unknown-linux-gnu
+	exit 0 ;;
+    ppc64:Linux:*:*)
+	echo powerpc64-unknown-linux-gnu
+	exit 0 ;;
+    alpha:Linux:*:*)
+	case `sed -n '/^cpu model/s/^.*: \(.*\)/\1/p' < /proc/cpuinfo` in
+	  EV5)   UNAME_MACHINE=alphaev5 ;;
+	  EV56)  UNAME_MACHINE=alphaev56 ;;
+	  PCA56) UNAME_MACHINE=alphapca56 ;;
+	  PCA57) UNAME_MACHINE=alphapca56 ;;
+	  EV6)   UNAME_MACHINE=alphaev6 ;;
+	  EV67)  UNAME_MACHINE=alphaev67 ;;
+	  EV68*) UNAME_MACHINE=alphaev68 ;;
+        esac
+	objdump --private-headers /bin/sh | grep ld.so.1 >/dev/null
+	if test "$?" = 0 ; then LIBC="libc1" ; else LIBC="" ; fi
+	echo ${UNAME_MACHINE}-unknown-linux-gnu${LIBC}
+	exit 0 ;;
+    parisc:Linux:*:* | hppa:Linux:*:*)
+	# Look for CPU level
+	case `grep '^cpu[^a-z]*:' /proc/cpuinfo 2>/dev/null | cut -d' ' -f2` in
+	  PA7*) echo hppa1.1-unknown-linux-gnu ;;
+	  PA8*) echo hppa2.0-unknown-linux-gnu ;;
+	  *)    echo hppa-unknown-linux-gnu ;;
+	esac
+	exit 0 ;;
+    parisc64:Linux:*:* | hppa64:Linux:*:*)
+	echo hppa64-unknown-linux-gnu
+	exit 0 ;;
+    s390:Linux:*:* | s390x:Linux:*:*)
+	echo ${UNAME_MACHINE}-ibm-linux
+	exit 0 ;;
+    sh*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    sparc:Linux:*:* | sparc64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    x86_64:Linux:*:*)
+	echo x86_64-unknown-linux-gnu
+	exit 0 ;;
+    i*86:Linux:*:*)
 	# The BFD linker knows what the default object file format is, so
 	# first see if it will tell us. cd to the root directory to prevent
 	# problems with other programs or directories called `ld' in the path.
-	ld_help_string=`cd /; ld --help 2>&1`
-	ld_supported_emulations=`echo $ld_help_string \
-			 | sed -ne '/supported emulations:/!d
+	ld_supported_targets=`cd /; ld --help 2>&1 \
+			 | sed -ne '/supported targets:/!d
 				    s/[ 	][ 	]*/ /g
-				    s/.*supported emulations: *//
+				    s/.*supported targets: *//
 				    s/ .*//
 				    p'`
-        case "$ld_supported_emulations" in
-	  *ia64)
-		echo "${UNAME_MACHINE}-unknown-linux"
-		exit 0
+        case "$ld_supported_targets" in
+	  elf32-i386)
+		TENTATIVE="${UNAME_MACHINE}-pc-linux-gnu"
 		;;
-	  i?86linux)
+	  a.out-i386-linux)
 		echo "${UNAME_MACHINE}-pc-linux-gnuaout"
-		exit 0
-		;;
-	  i?86coff)
+		exit 0 ;;		
+	  coff-i386)
 		echo "${UNAME_MACHINE}-pc-linux-gnucoff"
-		exit 0
-		;;
-	  sparclinux)
-		echo "${UNAME_MACHINE}-unknown-linux-gnuaout"
-		exit 0
-		;;
-	  armlinux)
-		echo "${UNAME_MACHINE}-unknown-linux-gnuaout"
-		exit 0
-		;;
-	  elf32arm*)
-		echo "${UNAME_MACHINE}-unknown-linux-gnu"
-		exit 0
-		;;
-	  armelf_linux*)
-		echo "${UNAME_MACHINE}-unknown-linux-gnu"
-		exit 0
-		;;
-	  m68klinux)
-		echo "${UNAME_MACHINE}-unknown-linux-gnuaout"
-		exit 0
-		;;
-	  elf32ppc)
-		# Determine Lib Version
-		cat >$dummy.c <<EOF
-#include <features.h>
-#if defined(__GLIBC__)
-extern char __libc_version[];
-extern char __libc_release[];
-#endif
-main(argc, argv)
-     int argc;
-     char *argv[];
-{
-#if defined(__GLIBC__)
-  printf("%s %s\n", __libc_version, __libc_release);
-#else
-  printf("unkown\n");
-#endif
-  return 0;
-}
-EOF
-		LIBC=""
-		$CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null
-		if test "$?" = 0 ; then
-			./$dummy | grep 1\.99 > /dev/null
-			if test "$?" = 0 ; then
-				LIBC="libc1"
-			fi
-		fi	
-		rm -f $dummy.c $dummy
-		echo powerpc-unknown-linux-gnu${LIBC}
-		exit 0
-		;;
+		exit 0 ;;
+	  "")
+		# Either a pre-BFD a.out linker (linux-gnuoldld) or
+		# one that does not give us useful --help.
+		echo "${UNAME_MACHINE}-pc-linux-gnuoldld"
+		exit 0 ;;
 	esac
-
-	if test "${UNAME_MACHINE}" = "alpha" ; then
-		sed 's/^	//'  <<EOF >$dummy.s
-		.globl main
-		.ent main
-	main:
-		.frame \$30,0,\$26,0
-		.prologue 0
-		.long 0x47e03d80 # implver $0
-		lda \$2,259
-		.long 0x47e20c21 # amask $2,$1
-		srl \$1,8,\$2
-		sll \$2,2,\$2
-		sll \$0,3,\$0
-		addl \$1,\$0,\$0
-		addl \$2,\$0,\$0
-		ret \$31,(\$26),1
-		.end main
-EOF
-		LIBC=""
-		$CC_FOR_BUILD $dummy.s -o $dummy 2>/dev/null
-		if test "$?" = 0 ; then
-			./$dummy
-			case "$?" in
-			7)
-				UNAME_MACHINE="alpha"
-				;;
-			15)
-				UNAME_MACHINE="alphaev5"
-				;;
-			14)
-				UNAME_MACHINE="alphaev56"
-				;;
-			10)
-				UNAME_MACHINE="alphapca56"
-				;;
-			16)
-				UNAME_MACHINE="alphaev6"
-				;;
-			esac
-
-			objdump --private-headers $dummy | \
-			  grep ld.so.1 > /dev/null
-			if test "$?" = 0 ; then
-				LIBC="libc1"
-			fi
-		fi
-		rm -f $dummy.s $dummy
-		echo ${UNAME_MACHINE}-unknown-linux-gnu${LIBC} ; exit 0
-	elif test "${UNAME_MACHINE}" = "mips" ; then
-	  cat >$dummy.c <<EOF
-#ifdef __cplusplus
-	int main (int argc, char *argv[]) {
-#else
-	int main (argc, argv) int argc; char *argv[]; {
-#endif
-#ifdef __MIPSEB__
-  printf ("%s-unknown-linux-gnu\n", argv[1]);
-#endif
-#ifdef __MIPSEL__
-  printf ("%sel-unknown-linux-gnu\n", argv[1]);
-#endif
-  return 0;
-}
-EOF
-	  $CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null && ./$dummy "${UNAME_MACHINE}" && rm $dummy.c $dummy && exit 0
-	  rm -f $dummy.c $dummy
-	else
-	  # Either a pre-BFD a.out linker (linux-gnuoldld)
-	  # or one that does not give us useful --help.
-	  # GCC wants to distinguish between linux-gnuoldld and linux-gnuaout.
-	  # If ld does not provide *any* "supported emulations:"
-	  # that means it is gnuoldld.
-	  echo "$ld_help_string" | grep >/dev/null 2>&1 "supported emulations:"
-	  test $? != 0 && echo "${UNAME_MACHINE}-pc-linux-gnuoldld" && exit 0
-
-	  case "${UNAME_MACHINE}" in
-	  i?86)
-	    VENDOR=pc;
-	    ;;
-	  *)
-	    VENDOR=unknown;
-	    ;;
-	  esac
-	  # Determine whether the default compiler is a.out or elf
-	  cat >$dummy.c <<EOF
+	# Determine whether the default compiler is a.out or elf
+	eval $set_cc_for_build
+	cat >$dummy.c <<EOF
 #include <features.h>
 #ifdef __cplusplus
+#include <stdio.h>  /* for printf() prototype */
 	int main (int argc, char *argv[]) {
 #else
 	int main (argc, argv) int argc; char *argv[]; {
@@ -796,28 +863,30 @@
 #ifdef __ELF__
 # ifdef __GLIBC__
 #  if __GLIBC__ >= 2
-    printf ("%s-${VENDOR}-linux-gnu\n", argv[1]);
+    printf ("%s-pc-linux-gnu\n", argv[1]);
 #  else
-    printf ("%s-${VENDOR}-linux-gnulibc1\n", argv[1]);
+    printf ("%s-pc-linux-gnulibc1\n", argv[1]);
 #  endif
 # else
-   printf ("%s-${VENDOR}-linux-gnulibc1\n", argv[1]);
+   printf ("%s-pc-linux-gnulibc1\n", argv[1]);
 # endif
 #else
-  printf ("%s-${VENDOR}-linux-gnuaout\n", argv[1]);
+  printf ("%s-pc-linux-gnuaout\n", argv[1]);
 #endif
   return 0;
 }
 EOF
-	  $CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null && ./$dummy "${UNAME_MACHINE}" && rm $dummy.c $dummy && exit 0
-	  rm -f $dummy.c $dummy
-	fi ;;
-# ptx 4.0 does uname -s correctly, with DYNIX/ptx in there.  earlier versions
-# are messed up and put the nodename in both sysname and nodename.
-    i?86:DYNIX/ptx:4*:*)
+	$CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null && ./$dummy "${UNAME_MACHINE}" && rm -f $dummy.c $dummy && exit 0
+	rm -f $dummy.c $dummy
+	test x"${TENTATIVE}" != x && echo "${TENTATIVE}" && exit 0
+	;;
+    i*86:DYNIX/ptx:4*:*)
+	# ptx 4.0 does uname -s correctly, with DYNIX/ptx in there.
+	# earlier versions are messed up and put the nodename in both
+	# sysname and nodename.
 	echo i386-sequent-sysv4
 	exit 0 ;;
-    i?86:UNIX_SV:4.2MP:2.*)
+    i*86:UNIX_SV:4.2MP:2.*)
         # Unixware is an offshoot of SVR4, but it has its own version
         # number series starting with 2...
         # I am not positive that other SVR4 systems won't match this,
@@ -825,7 +894,7 @@
         # Use sysv4.2uw... so that sysv4* matches it.
 	echo ${UNAME_MACHINE}-pc-sysv4.2uw${UNAME_VERSION}
 	exit 0 ;;
-    i?86:*:4.*:* | i?86:SYSTEM_V:4.*:*)
+    i*86:*:4.*:* | i*86:SYSTEM_V:4.*:*)
 	UNAME_REL=`echo ${UNAME_RELEASE} | sed 's/\/MP$//'`
 	if grep Novell /usr/include/link.h >/dev/null 2>/dev/null; then
 		echo ${UNAME_MACHINE}-univel-sysv${UNAME_REL}
@@ -833,16 +902,15 @@
 		echo ${UNAME_MACHINE}-pc-sysv${UNAME_REL}
 	fi
 	exit 0 ;;
-    i?86:*:5:7*)
-        # Fixed at (any) Pentium or better
-        UNAME_MACHINE=i586
-        if [ ${UNAME_SYSTEM} = "UnixWare" ] ; then
-	    echo ${UNAME_MACHINE}-sco-sysv${UNAME_RELEASE}uw${UNAME_VERSION}
-	else
-	    echo ${UNAME_MACHINE}-pc-sysv${UNAME_RELEASE}
-	fi
+    i*86:*:5:[78]*)
+	case `/bin/uname -X | grep "^Machine"` in
+	    *486*)	     UNAME_MACHINE=i486 ;;
+	    *Pentium)	     UNAME_MACHINE=i586 ;;
+	    *Pent*|*Celeron) UNAME_MACHINE=i686 ;;
+	esac
+	echo ${UNAME_MACHINE}-unknown-sysv${UNAME_RELEASE}${UNAME_SYSTEM}${UNAME_VERSION}
 	exit 0 ;;
-    i?86:*:3.2:*)
+    i*86:*:3.2:*)
 	if test -f /usr/options/cb.name; then
 		UNAME_REL=`sed -n 's/.*Version //p' </usr/options/cb.name`
 		echo ${UNAME_MACHINE}-pc-isc$UNAME_REL
@@ -860,7 +928,11 @@
 		echo ${UNAME_MACHINE}-pc-sysv32
 	fi
 	exit 0 ;;
+    i*86:*DOS:*:*)
+	echo ${UNAME_MACHINE}-pc-msdosdjgpp
+	exit 0 ;;
     pc:*:*:*)
+	# Left here for compatibility:
         # uname -m prints for DJGPP always 'pc', but it prints nothing about
         # the processor, so we play safe by assuming i386.
 	echo i386-pc-msdosdjgpp
@@ -884,7 +956,7 @@
 	exit 0 ;;
     M68*:*:R3V[567]*:*)
 	test -r /sysV68 && echo 'm68k-motorola-sysv' && exit 0 ;;
-    3[34]??:*:4.0:3.0 | 3[34]??,*:*:4.0:3.0 | 4850:*:4.0:3.0)
+    3[34]??:*:4.0:3.0 | 3[34]??A:*:4.0:3.0 | 3[34]??,*:*:4.0:3.0 | 4850:*:4.0:3.0)
 	OS_REL=''
 	test -r /etc/.relid \
 	&& OS_REL=.`sed -n 's/[^ ]* [^ ]* \([0-9][0-9]\).*/\1/p' < /etc/.relid`
@@ -895,21 +967,24 @@
     3[34]??:*:4.0:* | 3[34]??,*:*:4.0:*)
         /bin/uname -p 2>/dev/null | grep 86 >/dev/null \
           && echo i486-ncr-sysv4 && exit 0 ;;
-    m68*:LynxOS:2.*:*)
+    m68*:LynxOS:2.*:* | m68*:LynxOS:3.0*:*)
 	echo m68k-unknown-lynxos${UNAME_RELEASE}
 	exit 0 ;;
     mc68030:UNIX_System_V:4.*:*)
 	echo m68k-atari-sysv4
 	exit 0 ;;
-    i?86:LynxOS:2.*:* | i?86:LynxOS:3.[01]*:*)
+    i*86:LynxOS:2.*:* | i*86:LynxOS:3.[01]*:* | i*86:LynxOS:4.0*:*)
 	echo i386-unknown-lynxos${UNAME_RELEASE}
 	exit 0 ;;
     TSUNAMI:LynxOS:2.*:*)
 	echo sparc-unknown-lynxos${UNAME_RELEASE}
 	exit 0 ;;
-    rs6000:LynxOS:2.*:* | PowerPC:LynxOS:2.*:*)
+    rs6000:LynxOS:2.*:*)
 	echo rs6000-unknown-lynxos${UNAME_RELEASE}
 	exit 0 ;;
+    PowerPC:LynxOS:2.*:* | PowerPC:LynxOS:3.[01]*:* | PowerPC:LynxOS:4.0*:*)
+	echo powerpc-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
     SM[BE]S:UNIX_SV:*:*)
 	echo mips-dde-sysv${UNAME_RELEASE}
 	exit 0 ;;
@@ -927,8 +1002,8 @@
 		echo ns32k-sni-sysv
 	fi
 	exit 0 ;;
-    PENTIUM:CPunix:4.0*:*) # Unisys `ClearPath HMP IX 4000' SVR4/MP effort
-                           # says <Richard.M.Bartel@ccMail.Census.GOV>
+    PENTIUM:*:4.0*:*) # Unisys `ClearPath HMP IX 4000' SVR4/MP effort
+                      # says <Richard.M.Bartel@ccMail.Census.GOV>
         echo i586-unisys-sysv4
         exit 0 ;;
     *:UNIX_System_V:4*:FTX*)
@@ -940,10 +1015,14 @@
 	# From seanf@swdc.stratus.com.
 	echo i860-stratus-sysv4
 	exit 0 ;;
+    *:VOS:*:*)
+	# From Paul.Green@stratus.com.
+	echo hppa1.1-stratus-vos
+	exit 0 ;;
     mc68*:A/UX:*:*)
 	echo m68k-apple-aux${UNAME_RELEASE}
 	exit 0 ;;
-    news*:NEWS-OS:*:6*)
+    news*:NEWS-OS:6*:*)
 	echo mips-sony-newsos6
 	exit 0 ;;
     R[34]000:*System_V*:*:* | R4000:UNIX_SYSV:*:* | R*000:UNIX_SV:*:*)
@@ -974,14 +1053,76 @@
     *:Rhapsody:*:*)
 	echo ${UNAME_MACHINE}-apple-rhapsody${UNAME_RELEASE}
 	exit 0 ;;
+    *:Darwin:*:*)
+	echo `uname -p`-apple-darwin${UNAME_RELEASE}
+	exit 0 ;;
+    *:procnto*:*:* | *:QNX:[0123456789]*:*)
+	if test "${UNAME_MACHINE}" = "x86pc"; then
+		UNAME_MACHINE=pc
+	fi
+	echo `uname -p`-${UNAME_MACHINE}-nto-qnx
+	exit 0 ;;
     *:QNX:*:4*)
-	echo i386-qnx-qnx${UNAME_VERSION}
+	echo i386-pc-qnx
+	exit 0 ;;
+    NSR-[KW]:NONSTOP_KERNEL:*:*)
+	echo nsr-tandem-nsk${UNAME_RELEASE}
+	exit 0 ;;
+    *:NonStop-UX:*:*)
+	echo mips-compaq-nonstopux
+	exit 0 ;;
+    BS2000:POSIX*:*:*)
+	echo bs2000-siemens-sysv
+	exit 0 ;;
+    DS/*:UNIX_System_V:*:*)
+	echo ${UNAME_MACHINE}-${UNAME_SYSTEM}-${UNAME_RELEASE}
+	exit 0 ;;
+    *:Plan9:*:*)
+	# "uname -m" is not consistent, so use $cputype instead. 386
+	# is converted to i386 for consistency with other x86
+	# operating systems.
+	if test "$cputype" = "386"; then
+	    UNAME_MACHINE=i386
+	else
+	    UNAME_MACHINE="$cputype"
+	fi
+	echo ${UNAME_MACHINE}-unknown-plan9
+	exit 0 ;;
+    i*86:OS/2:*:*)
+	# If we were able to find `uname', then EMX Unix compatibility
+	# is probably installed.
+	echo ${UNAME_MACHINE}-pc-os2-emx
+	exit 0 ;;
+    *:TOPS-10:*:*)
+	echo pdp10-unknown-tops10
+	exit 0 ;;
+    *:TENEX:*:*)
+	echo pdp10-unknown-tenex
+	exit 0 ;;
+    KS10:TOPS-20:*:* | KL10:TOPS-20:*:* | TYPE4:TOPS-20:*:*)
+	echo pdp10-dec-tops20
+	exit 0 ;;
+    XKL-1:TOPS-20:*:* | TYPE5:TOPS-20:*:*)
+	echo pdp10-xkl-tops20
+	exit 0 ;;
+    *:TOPS-20:*:*)
+	echo pdp10-unknown-tops20
+	exit 0 ;;
+    *:ITS:*:*)
+	echo pdp10-unknown-its
+	exit 0 ;;
+    i*86:XTS-300:*:STOP)
+	echo ${UNAME_MACHINE}-unknown-stop
+	exit 0 ;;
+    i*86:atheos:*:*)
+	echo ${UNAME_MACHINE}-unknown-atheos
 	exit 0 ;;
 esac
 
 #echo '(No uname command or uname output not recognized.)' 1>&2
 #echo "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" 1>&2
 
+eval $set_cc_for_build
 cat >$dummy.c <<EOF
 #ifdef _SEQUENT_
 # include <sys/types.h>
@@ -1068,11 +1209,24 @@
 #endif
 
 #if defined (vax)
-#if !defined (ultrix)
-  printf ("vax-dec-bsd\n"); exit (0);
-#else
-  printf ("vax-dec-ultrix\n"); exit (0);
-#endif
+# if !defined (ultrix)
+#  include <sys/param.h>
+#  if defined (BSD)
+#   if BSD == 43
+      printf ("vax-dec-bsd4.3\n"); exit (0);
+#   else
+#    if BSD == 199006
+      printf ("vax-dec-bsd4.3reno\n"); exit (0);
+#    else
+      printf ("vax-dec-bsd\n"); exit (0);
+#    endif
+#   endif
+#  else
+    printf ("vax-dec-bsd\n"); exit (0);
+#  endif
+# else
+    printf ("vax-dec-ultrix\n"); exit (0);
+# endif
 #endif
 
 #if defined (alliant) && defined (i860)
@@ -1083,7 +1237,7 @@
 }
 EOF
 
-$CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null && ./$dummy && rm $dummy.c $dummy && exit 0
+$CC_FOR_BUILD $dummy.c -o $dummy 2>/dev/null && ./$dummy && rm -f $dummy.c $dummy && exit 0
 rm -f $dummy.c $dummy
 
 # Apollos put the system type in the environment.
@@ -1116,6 +1270,48 @@
     esac
 fi
 
-#echo '(Unable to guess system type)' 1>&2
+cat >&2 <<EOF
+$0: unable to guess system type
+
+This script, last modified $timestamp, has failed to recognize
+the operating system you are using. It is advised that you
+download the most up to date version of the config scripts from
+
+    ftp://ftp.gnu.org/pub/gnu/config/
+
+If the version you run ($0) is already up to date, please
+send the following data and any information you think might be
+pertinent to <config-patches@gnu.org> in order to provide the needed
+information to handle your system.
+
+config.guess timestamp = $timestamp
+
+uname -m = `(uname -m) 2>/dev/null || echo unknown`
+uname -r = `(uname -r) 2>/dev/null || echo unknown`
+uname -s = `(uname -s) 2>/dev/null || echo unknown`
+uname -v = `(uname -v) 2>/dev/null || echo unknown`
+
+/usr/bin/uname -p = `(/usr/bin/uname -p) 2>/dev/null`
+/bin/uname -X     = `(/bin/uname -X) 2>/dev/null`
+
+hostinfo               = `(hostinfo) 2>/dev/null`
+/bin/universe          = `(/bin/universe) 2>/dev/null`
+/usr/bin/arch -k       = `(/usr/bin/arch -k) 2>/dev/null`
+/bin/arch              = `(/bin/arch) 2>/dev/null`
+/usr/bin/oslevel       = `(/usr/bin/oslevel) 2>/dev/null`
+/usr/convex/getsysinfo = `(/usr/convex/getsysinfo) 2>/dev/null`
+
+UNAME_MACHINE = ${UNAME_MACHINE}
+UNAME_RELEASE = ${UNAME_RELEASE}
+UNAME_SYSTEM  = ${UNAME_SYSTEM}
+UNAME_VERSION = ${UNAME_VERSION}
+EOF
 
 exit 1
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp='"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
diff -uNr gtk+-1.2.10-orig/config.sub gtk+-1.2.10/config.sub
--- gtk+-1.2.10-orig/config.sub	2000-02-03 12:07:42.000000000 +1100
+++ gtk+-1.2.10/config.sub	2005-01-27 01:12:59.011948611 +1100
@@ -1,6 +1,10 @@
 #! /bin/sh
-# Configuration validation subroutine script, version 1.1.
-#   Copyright (C) 1991, 92-97, 1998, 1999 Free Software Foundation, Inc.
+# Configuration validation subroutine script.
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
+#   Free Software Foundation, Inc.
+
+timestamp='2001-09-07'
+
 # This file is (in principle) common to ALL GNU software.
 # The presence of a machine in this file suggests that SOME GNU software
 # can handle that machine.  It does not imply ALL GNU software can.
@@ -25,6 +29,8 @@
 # configuration script generated by Autoconf, you may include it under
 # the same distribution terms that you use for the rest of that program.
 
+# Please send patches to <config-patches@gnu.org>.
+#
 # Configuration subroutine to validate and canonicalize a configuration type.
 # Supply the specified configuration type as an argument.
 # If it is invalid, we print an error message on stderr and exit with code 1.
@@ -45,30 +51,73 @@
 #	CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM
 # It is wrong to echo any other type of specification.
 
-if [ x$1 = x ]
-then
-	echo Configuration name missing. 1>&2
-	echo "Usage: $0 CPU-MFR-OPSYS" 1>&2
-	echo "or     $0 ALIAS" 1>&2
-	echo where ALIAS is a recognized configuration type. 1>&2
-	exit 1
-fi
+me=`echo "$0" | sed -e 's,.*/,,'`
 
-# First pass through any local machine types.
-case $1 in
-	*local*)
-		echo $1
-		exit 0
-		;;
-	*)
-	;;
+usage="\
+Usage: $0 [OPTION] CPU-MFR-OPSYS
+       $0 [OPTION] ALIAS
+
+Canonicalize a configuration name.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version="\
+GNU config.sub ($timestamp)
+
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
+
+help="
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit 0 ;;
+    --version | -v )
+       echo "$version" ; exit 0 ;;
+    --help | --h* | -h )
+       echo "$usage"; exit 0 ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help"
+       exit 1 ;;
+
+    *local*)
+       # First pass through any local machine types.
+       echo $1
+       exit 0;;
+
+    * )
+       break ;;
+  esac
+done
+
+case $# in
+ 0) echo "$me: missing argument$help" >&2
+    exit 1;;
+ 1) ;;
+ *) echo "$me: too many arguments$help" >&2
+    exit 1;;
 esac
 
 # Separate what the user gave into CPU-COMPANY and OS or KERNEL-OS (if any).
 # Here we must recognize all the valid KERNEL-OS combinations.
 maybe_os=`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\2/'`
 case $maybe_os in
-  linux-gnu*)
+  nto-qnx* | linux-gnu* | storm-chaos* | os2-emx* | windows32-*)
     os=-$maybe_os
     basic_machine=`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\1/'`
     ;;
@@ -94,7 +143,7 @@
 	-convergent* | -ncr* | -news | -32* | -3600* | -3100* | -hitachi* |\
 	-c[123]* | -convex* | -sun | -crds | -omron* | -dg | -ultra | -tti* | \
 	-harris | -dolphin | -highlevel | -gould | -cbm | -ns | -masscomp | \
-	-apple)
+	-apple | -axis)
 		os=
 		basic_machine=$1
 		;;
@@ -108,6 +157,14 @@
 		os=-vxworks
 		basic_machine=$1
 		;;
+	-chorusos*)
+		os=-chorusos
+		basic_machine=$1
+		;;
+ 	-chorusrdb)
+ 		os=-chorusrdb
+		basic_machine=$1
+ 		;;
 	-hiux*)
 		os=-hiuxwe2
 		;;
@@ -166,27 +223,50 @@
 case $basic_machine in
 	# Recognize the basic CPU types without company name.
 	# Some are omitted here because they have special meanings below.
-	tahoe | i860 | ia64 | m32r | m68k | m68000 | m88k | ns32k | arc | arm \
-		| arme[lb] | pyramid | mn10200 | mn10300 | tron | a29k \
-		| 580 | i960 | h8300 \
-		| hppa | hppa1.0 | hppa1.1 | hppa2.0 | hppa2.0w | hppa2.0n \
-		| alpha | alphaev[4-7] | alphaev56 | alphapca5[67] \
-		| we32k | ns16k | clipper | i370 | sh | powerpc | powerpcle \
-		| 1750a | dsp16xx | pdp11 | mips16 | mips64 | mipsel | mips64el \
-		| mips64orion | mips64orionel | mipstx39 | mipstx39el \
-		| mips64vr4300 | mips64vr4300el | mips64vr4100 | mips64vr4100el \
-		| mips64vr5000 | miprs64vr5000el | mcore \
-		| sparc | sparclet | sparclite | sparc64 | sparcv9 | v850 | c4x \
-		| thumb | d10v | fr30)
+	1750a | 580 \
+	| a29k \
+	| alpha | alphaev[4-8] | alphaev56 | alphaev6[78] | alphapca5[67] \
+	| arc | arm | arm[bl]e | arme[lb] | armv[2345] | armv[345][lb] | avr \
+	| c4x | clipper \
+	| d10v | d30v | dsp16xx \
+	| fr30 \
+	| h8300 | h8500 | hppa | hppa1.[01] | hppa2.0 | hppa2.0[nw] | hppa64 \
+	| i370 | i860 | i960 | ia64 \
+	| m32r | m68000 | m68k | m88k | mcore \
+	| mips16 | mips64 | mips64el | mips64orion | mips64orionel \
+	| mips64vr4100 | mips64vr4100el | mips64vr4300 \
+	| mips64vr4300el | mips64vr5000 | mips64vr5000el \
+	| mipsbe | mipseb | mipsel | mipsle | mipstx39 | mipstx39el \
+	| mipsisa32 \
+	| mn10200 | mn10300 \
+	| ns16k | ns32k \
+	| openrisc \
+	| pdp10 | pdp11 | pj | pjl \
+	| powerpc | powerpc64 | powerpc64le | powerpcle | ppcbe \
+	| pyramid \
+	| s390 | s390x \
+	| sh | sh[34] | sh[34]eb | shbe | shle \
+	| sparc | sparc64 | sparclet | sparclite | sparcv9 | sparcv9b \
+	| stormy16 | strongarm \
+	| tahoe | thumb | tic80 | tron \
+	| v850 \
+	| we32k \
+	| x86 | xscale \
+	| z8k)
 		basic_machine=$basic_machine-unknown
 		;;
-	m88110 | m680[12346]0 | m683?2 | m68360 | m5200 | z8k | v70 | h8500 | w65 | pj | pjl)
+	m6811 | m68hc11 | m6812 | m68hc12)
+		# Motorola 68HC11/12.
+		basic_machine=$basic_machine-unknown
+		os=-none
+		;;
+	m88110 | m680[12346]0 | m683?2 | m68360 | m5200 | v70 | w65 | z8k)
 		;;
 
 	# We use `pc' rather than `unknown'
 	# because (1) that's what they normally are, and
 	# (2) the word "unknown" tends to confuse beginning users.
-	i[34567]86)
+	i*86 | x86_64)
 	  basic_machine=$basic_machine-pc
 	  ;;
 	# Object if more than one company name word.
@@ -195,24 +275,43 @@
 		exit 1
 		;;
 	# Recognize the basic CPU types with company name.
-	# FIXME: clean up the formatting here.
-	vax-* | tahoe-* | i[34567]86-* | i860-* | ia64-* | m32r-* | m68k-* | m68000-* \
-	      | m88k-* | sparc-* | ns32k-* | fx80-* | arc-* | arm-* | c[123]* \
-	      | mips-* | pyramid-* | tron-* | a29k-* | romp-* | rs6000-* \
-	      | power-* | none-* | 580-* | cray2-* | h8300-* | h8500-* | i960-* \
-	      | xmp-* | ymp-* \
-	      | hppa-* | hppa1.0-* | hppa1.1-* | hppa2.0-* | hppa2.0w-* | hppa2.0n-* \
-	      | alpha-* | alphaev[4-7]-* | alphaev56-* | alphapca5[67]-* \
-	      | we32k-* | cydra-* | ns16k-* | pn-* | np1-* | xps100-* \
-	      | clipper-* | orion-* \
-	      | sparclite-* | pdp11-* | sh-* | powerpc-* | powerpcle-* \
-	      | sparc64-* | sparcv9-* | sparc86x-* | mips16-* | mips64-* | mipsel-* \
-	      | mips64el-* | mips64orion-* | mips64orionel-* \
-	      | mips64vr4100-* | mips64vr4100el-* | mips64vr4300-* | mips64vr4300el-* \
-	      | mipstx39-* | mipstx39el-* | mcore-* \
-	      | f301-* | armv*-* | t3e-* \
-	      | m88110-* | m680[01234]0-* | m683?2-* | m68360-* | z8k-* | d10v-* \
-	      | thumb-* | v850-* | d30v-* | tic30-* | c30-* | fr30-* )
+	580-* \
+	| a29k-* \
+	| alpha-* | alphaev[4-8]-* | alphaev56-* | alphaev6[78]-* \
+	| alphapca5[67]-* | arc-* \
+	| arm-*  | armbe-* | armle-* | armv*-* \
+	| bs2000-* \
+	| c[123]* | c30-* | [cjt]90-* | c54x-* \
+	| clipper-* | cray2-* | cydra-* \
+	| d10v-* | d30v-* \
+	| elxsi-* \
+	| f30[01]-* | f700-* | fr30-* | fx80-* \
+	| h8300-* | h8500-* \
+	| hppa-* | hppa1.[01]-* | hppa2.0-* | hppa2.0[nw]-* | hppa64-* \
+	| i*86-* | i860-* | i960-* | ia64-* \
+	| m32r-* \
+	| m68000-* | m680[01234]0-* | m68360-* | m683?2-* | m68k-* \
+	| m88110-* | m88k-* | mcore-* \
+	| mips-* | mips16-* | mips64-* | mips64el-* | mips64orion-* \
+	| mips64orionel-* | mips64vr4100-* | mips64vr4100el-* \
+	| mips64vr4300-* | mips64vr4300el-* | mipsbe-* | mipseb-* \
+	| mipsle-* | mipsel-* | mipstx39-* | mipstx39el-* \
+	| none-* | np1-* | ns16k-* | ns32k-* \
+	| orion-* \
+	| pdp10-* | pdp11-* | pj-* | pjl-* | pn-* | power-* \
+	| powerpc-* | powerpc64-* | powerpc64le-* | powerpcle-* | ppcbe-* \
+	| pyramid-* \
+	| romp-* | rs6000-* \
+	| s390-* | s390x-* \
+	| sh-* | sh[34]-* | sh[34]eb-* | shbe-* | shle-* \
+	| sparc-* | sparc64-* | sparc86x-* | sparclite-* \
+	| sparcv9-* | sparcv9b-* | stormy16-* | strongarm-* | sv1-* \
+	| t3e-* | tahoe-* | thumb-* | tic30-* | tic54x-* | tic80-* | tron-* \
+	| v850-* | vax-* \
+	| we32k-* \
+	| x86-* | x86_64-* | xmp-* | xps100-* | xscale-* \
+	| ymp-* \
+	| z8k-*)
 		;;
 	# Recognize the various machine names and aliases which stand
 	# for a CPU type and a company and sometimes even an OS.
@@ -249,14 +348,14 @@
 		os=-sysv
 		;;
 	amiga | amiga-*)
-		basic_machine=m68k-cbm
+		basic_machine=m68k-unknown
 		;;
 	amigaos | amigados)
-		basic_machine=m68k-cbm
+		basic_machine=m68k-unknown
 		os=-amigaos
 		;;
 	amigaunix | amix)
-		basic_machine=m68k-cbm
+		basic_machine=m68k-unknown
 		os=-sysv4
 		;;
 	apollo68)
@@ -303,13 +402,16 @@
 		basic_machine=cray2-cray
 		os=-unicos
 		;;
-	[ctj]90-cray)
-		basic_machine=c90-cray
+	[cjt]90)
+		basic_machine=${basic_machine}-cray
 		os=-unicos
 		;;
 	crds | unos)
 		basic_machine=m68k-crds
 		;;
+	cris | cris-* | etrax*)
+		basic_machine=cris-axis
+		;;
 	da30 | da30-*)
 		basic_machine=m68k-da30
 		;;
@@ -357,6 +459,10 @@
 		basic_machine=tron-gmicro
 		os=-sysv
 		;;
+	go32)
+		basic_machine=i386-pc
+		os=-go32
+		;;
 	h3050r* | hiux*)
 		basic_machine=hppa1.1-hitachi
 		os=-hiuxwe2
@@ -432,19 +538,19 @@
 		basic_machine=i370-ibm
 		;;
 # I'm not sure what "Sysv32" means.  Should this be sysv3.2?
-	i[34567]86v32)
+	i*86v32)
 		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
 		os=-sysv32
 		;;
-	i[34567]86v4*)
+	i*86v4*)
 		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
 		os=-sysv4
 		;;
-	i[34567]86v)
+	i*86v)
 		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
 		os=-sysv
 		;;
-	i[34567]86sol2)
+	i*86sol2)
 		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
 		os=-solaris2
 		;;
@@ -456,17 +562,6 @@
 		basic_machine=i386-unknown
 		os=-vsta
 		;;
-	i386-go32 | go32)
-		basic_machine=i386-unknown
-		os=-go32
-		;;
-	i386-mingw32 | mingw32)
-		basic_machine=i386-unknown
-		os=-mingw32
-		;;
-	i386-qnx | qnx)
-		basic_machine=i386-qnx
-		;;
 	iris | iris4d)
 		basic_machine=mips-sgi
 		case $os in
@@ -492,6 +587,10 @@
 		basic_machine=ns32k-utek
 		os=-sysv
 		;;
+	mingw32)
+		basic_machine=i386-pc
+		os=-mingw32
+		;;
 	miniframe)
 		basic_machine=m68000-convergent
 		;;
@@ -513,12 +612,16 @@
 	mips3*)
 		basic_machine=`echo $basic_machine | sed -e 's/mips3/mips64/'`-unknown
 		;;
+	mmix*)
+		basic_machine=mmix-knuth
+		os=-mmixware
+		;;
 	monitor)
 		basic_machine=m68k-rom68k
 		os=-coff
 		;;
 	msdos)
-		basic_machine=i386-unknown
+		basic_machine=i386-pc
 		os=-msdos
 		;;
 	mvs)
@@ -582,9 +685,16 @@
 		basic_machine=i960-intel
 		os=-mon960
 		;;
+	nonstopux)
+		basic_machine=mips-compaq
+		os=-nonstopux
+		;;
 	np1)
 		basic_machine=np1-gould
 		;;
+	nsr-tandem)
+		basic_machine=nsr-tandem
+		;;
 	op50n-* | op60c-*)
 		basic_machine=hppa1.1-oki
 		os=-proelf
@@ -614,28 +724,28 @@
         pc532 | pc532-*)
 		basic_machine=ns32k-pc532
 		;;
-	pentium | p5 | k5 | k6 | nexen)
+	pentium | p5 | k5 | k6 | nexgen)
 		basic_machine=i586-pc
 		;;
-	pentiumpro | p6 | 6x86)
+	pentiumpro | p6 | 6x86 | athlon)
 		basic_machine=i686-pc
 		;;
 	pentiumii | pentium2)
-		basic_machine=i786-pc
+		basic_machine=i686-pc
 		;;
-	pentium-* | p5-* | k5-* | k6-* | nexen-*)
+	pentium-* | p5-* | k5-* | k6-* | nexgen-*)
 		basic_machine=i586-`echo $basic_machine | sed 's/^[^-]*-//'`
 		;;
-	pentiumpro-* | p6-* | 6x86-*)
+	pentiumpro-* | p6-* | 6x86-* | athlon-*)
 		basic_machine=i686-`echo $basic_machine | sed 's/^[^-]*-//'`
 		;;
 	pentiumii-* | pentium2-*)
-		basic_machine=i786-`echo $basic_machine | sed 's/^[^-]*-//'`
+		basic_machine=i686-`echo $basic_machine | sed 's/^[^-]*-//'`
 		;;
 	pn)
 		basic_machine=pn-gould
 		;;
-	power)	basic_machine=rs6000-ibm
+	power)	basic_machine=power-ibm
 		;;
 	ppc)	basic_machine=powerpc-unknown
 	        ;;
@@ -647,9 +757,23 @@
 	ppcle-* | powerpclittle-*)
 		basic_machine=powerpcle-`echo $basic_machine | sed 's/^[^-]*-//'`
 		;;
+	ppc64)	basic_machine=powerpc64-unknown
+	        ;;
+	ppc64-*) basic_machine=powerpc64-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppc64le | powerpc64little | ppc64-le | powerpc64-little)
+		basic_machine=powerpc64le-unknown
+	        ;;
+	ppc64le-* | powerpc64little-*)
+		basic_machine=powerpc64le-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
 	ps2)
 		basic_machine=i386-ibm
 		;;
+	pw32)
+		basic_machine=i586-unknown
+		os=-pw32
+		;;
 	rom68k)
 		basic_machine=m68k-rom68k
 		os=-coff
@@ -729,6 +853,10 @@
 	sun386 | sun386i | roadrunner)
 		basic_machine=i386-sun
 		;;
+	sv1)
+		basic_machine=sv1-cray
+		os=-unicos
+		;;
 	symmetry)
 		basic_machine=i386-sequent
 		os=-dynix
@@ -737,6 +865,10 @@
 		basic_machine=t3e-cray
 		os=-unicos
 		;;
+	tic54x | c54x*)
+		basic_machine=tic54x-unknown
+		os=-coff
+		;;
 	tx39)
 		basic_machine=mipstx39-unknown
 		;;
@@ -789,6 +921,10 @@
 		basic_machine=hppa1.1-winbond
 		os=-proelf
 		;;
+	windows32)
+		basic_machine=i386-pc
+		os=-windows32-msvcrt
+		;;
 	xmp)
 		basic_machine=xmp-cray
 		os=-unicos
@@ -832,13 +968,20 @@
 	vax)
 		basic_machine=vax-dec
 		;;
+	pdp10)
+		# there are many clones, so DEC is not a safe bet
+		basic_machine=pdp10-unknown
+		;;
 	pdp11)
 		basic_machine=pdp11-dec
 		;;
 	we32k)
 		basic_machine=we32k-att
 		;;
-	sparc | sparcv9)
+	sh3 | sh4 | sh3eb | sh4eb)
+		basic_machine=sh-unknown
+		;;
+	sparc | sparcv9 | sparcv9b)
 		basic_machine=sparc-sun
 		;;
         cydra)
@@ -860,6 +1003,9 @@
 		basic_machine=c4x-none
 		os=-coff
 		;;
+	*-unknown)
+		# Make sure to match an already-canonicalized machine name.
+		;;
 	*)
 		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recognized 1>&2
 		exit 1
@@ -916,14 +1062,30 @@
 	      | -lynxos* | -bosx* | -nextstep* | -cxux* | -aout* | -elf* | -oabi* \
 	      | -ptx* | -coff* | -ecoff* | -winnt* | -domain* | -vsta* \
 	      | -udi* | -eabi* | -lites* | -ieee* | -go32* | -aux* \
+	      | -chorusos* | -chorusrdb* \
 	      | -cygwin* | -pe* | -psos* | -moss* | -proelf* | -rtems* \
 	      | -mingw32* | -linux-gnu* | -uxpv* | -beos* | -mpeix* | -udk* \
-	      | -interix* | -uwin* | -rhapsody* | -opened* | -openstep* | -oskit*)
+	      | -interix* | -uwin* | -rhapsody* | -darwin* | -opened* \
+	      | -openstep* | -oskit* | -conix* | -pw32* | -nonstopux* \
+	      | -storm-chaos* | -tops10* | -tenex* | -tops20* | -its* \
+	      | -os2* | -vos*)
 	# Remember, each alternative MUST END IN *, to match a version number.
 		;;
+	-qnx*)
+		case $basic_machine in
+		    x86-* | i*86-*)
+			;;
+		    *)
+			os=-nto$os
+			;;
+		esac
+		;;
+	-nto*)
+		os=-nto-qnx
+		;;
 	-sim | -es1800* | -hms* | -xray | -os68k* | -none* | -v88r* \
 	      | -windows* | -osx | -abug | -netware* | -os9* | -beos* \
-	      | -macos* | -mpw* | -magic* | -mon960* | -lnews*)
+	      | -macos* | -mpw* | -magic* | -mmixware* | -mon960* | -lnews*)
 		;;
 	-mac*)
 		os=`echo $os | sed -e 's|mac|macos|'`
@@ -940,6 +1102,9 @@
 	-opened*)
 		os=-openedition
 		;;
+	-wince*)
+		os=-wince
+		;;
 	-osfrose*)
 		os=-osfrose
 		;;
@@ -964,6 +1129,9 @@
 	-ns2 )
 	        os=-nextstep2
 		;;
+	-nsk*)
+		os=-nsk
+		;;
 	# Preserve the version number of sinix5.
 	-sinix5.*)
 		os=`echo $os | sed -e 's|sinix|sysv|'`
@@ -977,9 +1145,6 @@
 	-oss*)
 		os=-sysv3
 		;;
-        -qnx)
-		os=-qnx4
-		;;
 	-svr4)
 		os=-sysv4
 		;;
@@ -1001,7 +1166,7 @@
 	-xenix)
 		os=-xenix
 		;;
-        -*mint | -*MiNT)
+        -*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
 	        os=-mint
 		;;
 	-none)
@@ -1035,6 +1200,9 @@
 	arm*-semi)
 		os=-aout
 		;;
+	pdp10-*)
+		os=-tops20
+		;;
         pdp11-*)
 		os=-none
 		;;
@@ -1143,7 +1311,7 @@
 	*-masscomp)
 		os=-rtu
 		;;
-	f301-fujitsu)
+	f30[01]-fujitsu | f700-fujitsu)
 		os=-uxpv
 		;;
 	*-rom68k)
@@ -1221,12 +1389,23 @@
 			-mpw* | -macos*)
 				vendor=apple
 				;;
-			-*mint | -*MiNT)
+			-*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
 				vendor=atari
 				;;
+			-vos*)
+				vendor=stratus
+				;;
 		esac
 		basic_machine=`echo $basic_machine | sed "s/unknown/$vendor/"`
 		;;
 esac
 
 echo $basic_machine$os
+exit 0
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp='"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
RALPHSBUILD

  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
