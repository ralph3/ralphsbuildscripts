#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.01"

DIR="cdrtools-${VERSION}"
TARBALL="cdrtools-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
 http://mirror.cict.fr/blfs/svn/c/${TARBALL}
 ftp://ftp.berlios.de/pub/cdrecord/${TARBALL}
)

MD5SUMS=(
d44a81460e97ae02931c31188fe8d3fd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
cat << "EOF" | patch -Np1 || return 1
diff -Naur cdrtools-2.01/cdda2wav/cdda2wav.c cdrtools-2.01.patched/cdda2wav/cdda2wav.c
--- cdrtools-2.01/cdda2wav/cdda2wav.c	2004-08-24 11:06:14.000000000 -0400
+++ cdrtools-2.01.patched/cdda2wav/cdda2wav.c	2009-05-27 18:38:08.000000000 -0400
@@ -901,8 +901,8 @@
 
 
 #if !defined (HAVE_STRTOUL) || (HAVE_STRTOUL != 1)
-static unsigned int strtoul __PR(( const char *s1, char **s2, int base ));
-static unsigned int strtoul(s1, s2, base)
+static unsigned int _strtoul __PR(( const char *s1, char **s2, int base ));
+static unsigned int _strtoul(s1, s2, base)
         const char *s1;
         char **s2;
 	int base;
@@ -1941,7 +1941,7 @@
 		}
 		else {
 			char	*endptr;
-			unsigned arg = strtoul(optstr, &endptr, 10);
+			unsigned arg = _strtoul(optstr, &endptr, 10);
 			if (optstr != endptr
 				&& arg <= SHOW_MAX) {
 				*flagp |= arg;
@@ -2237,8 +2237,8 @@
 	if (trackspec) {
 		char * endptr;
 		char * endptr2;
-		track = strtoul(trackspec, &endptr, 10 );
-		endtrack = strtoul(endptr, &endptr2, 10 );
+		track = _strtoul(trackspec, &endptr, 10 );
+		endtrack = _strtoul(endptr, &endptr2, 10 );
 		if (endptr2 == endptr) {
 			endtrack = track;
 		} else if (track == endtrack) {
diff -Naur cdrtools-2.01/cdda2wav/config.h cdrtools-2.01.patched/cdda2wav/config.h
--- cdrtools-2.01/cdda2wav/config.h	2003-10-06 13:03:58.000000000 -0400
+++ cdrtools-2.01.patched/cdda2wav/config.h	2009-05-27 18:28:42.000000000 -0400
@@ -32,7 +32,7 @@
 #define CONCAT(a,b)	a/**/b
 #endif
 
-#include "lconfig.h"
+//#include "lconfig.h"
 
 /* temporary until a autoconf check is present */
 #ifdef	__BEOS__
diff -Naur cdrtools-2.01/cdrecord/cue.c cdrtools-2.01.patched/cdrecord/cue.c
--- cdrtools-2.01/cdrecord/cue.c	2004-03-02 15:00:53.000000000 -0500
+++ cdrtools-2.01.patched/cdrecord/cue.c	2009-05-27 18:40:29.000000000 -0400
@@ -249,7 +249,7 @@
 LOCAL	char	*peekword	__PR((void));
 LOCAL	char	*lineend	__PR((void));
 LOCAL	char	*markword	__PR((char *delim));
-LOCAL	char	getdelim	__PR((void));
+LOCAL	char	_getdelim	__PR((void));
 LOCAL	char	*getnextitem	__PR((char *delim));
 LOCAL	char	*neednextitem	__PR((char *delim));
 LOCAL	char	*nextword	__PR((void));
@@ -772,7 +772,7 @@
 	if (kp == NULL)
 		cueabort("Unknown filetype '%s'", word);
 
-	if (getdelim() == '/') {
+	if (_getdelim() == '/') {
 		word = needitem();
 		if (*astol(++word, &secsize) != '\0')
 			cueabort("Not a number '%s'", word);
@@ -1163,7 +1163,7 @@
 }
 
 LOCAL char
-getdelim()
+_getdelim()
 {
 	return (wordendc);
 }
diff -Naur cdrtools-2.01/include/schily.h cdrtools-2.01.patched/include/schily.h
--- cdrtools-2.01/include/schily.h	2004-03-04 19:30:40.000000000 -0500
+++ cdrtools-2.01.patched/include/schily.h	2009-05-27 18:25:48.000000000 -0400
@@ -108,7 +108,7 @@
 		/* 6th arg not const, fexecv forces av[ac] = NULL */
 extern	int	fexecv __PR((const char *, FILE *, FILE *, FILE *, int,
 							char **));
-extern	int	fexecve __PR((const char *, FILE *, FILE *, FILE *,
+extern	int	_fexecve __PR((const char *, FILE *, FILE *, FILE *,
 					char * const *, char * const *));
 extern	int	fspawnv __PR((FILE *, FILE *, FILE *, int, char * const *));
 extern	int	fspawnl __PR((FILE *, FILE *, FILE *,
@@ -187,7 +187,7 @@
 extern	char	*findbytes __PR((const void *, int, char));
 extern	int	findline __PR((const char *, char, const char *,
 							int, char **, int));
-extern	int	getline __PR((char *, int));
+extern	int	_getline __PR((char *, int));
 extern	int	getstr __PR((char *, int));
 extern	int	breakline __PR((char *, char, char **, int));
 extern	int	getallargs __PR((int *, char * const**, const char *, ...));
diff -Naur cdrtools-2.01/libscg/scsitransp.c cdrtools-2.01.patched/libscg/scsitransp.c
--- cdrtools-2.01/libscg/scsitransp.c	2004-06-17 16:20:27.000000000 -0400
+++ cdrtools-2.01.patched/libscg/scsitransp.c	2009-05-27 18:25:48.000000000 -0400
@@ -323,7 +323,7 @@
 
 	js_printf("%s", msg);
 	flush();
-	if (getline(okbuf, sizeof (okbuf)) == EOF)
+	if (_getline(okbuf, sizeof (okbuf)) == EOF)
 		exit(EX_BAD);
 	if (streql(okbuf, "y") || streql(okbuf, "yes") ||
 	    streql(okbuf, "Y") || streql(okbuf, "YES"))
diff -Naur cdrtools-2.01/libschily/fexec.c cdrtools-2.01.patched/libschily/fexec.c
--- cdrtools-2.01/libschily/fexec.c	2004-06-06 07:50:24.000000000 -0400
+++ cdrtools-2.01.patched/libschily/fexec.c	2009-05-27 18:25:48.000000000 -0400
@@ -159,7 +159,7 @@
 	} while (p != NULL);
 	va_end(args);
 
-	ret = fexecve(name, in, out, err, av, env);
+	ret = _fexecve(name, in, out, err, av, env);
 	if (av != xav)
 		free(av);
 	return (ret);
@@ -173,11 +173,11 @@
 	char *av[];
 {
 	av[ac] = NULL;			/*  force list to be null terminated */
-	return (fexecve(name, in, out, err, av, environ));
+	return (_fexecve(name, in, out, err, av, environ));
 }
 
 EXPORT int
-fexecve(name, in, out, err, av, env)
+_fexecve(name, in, out, err, av, env)
 	const char *name;
 	FILE *in, *out, *err;
 	char * const av[], * const env[];
diff -Naur cdrtools-2.01/libschily/stdio/fgetline.c cdrtools-2.01.patched/libschily/stdio/fgetline.c
--- cdrtools-2.01/libschily/stdio/fgetline.c	2004-08-08 07:02:05.000000000 -0400
+++ cdrtools-2.01.patched/libschily/stdio/fgetline.c	2009-05-27 18:25:48.000000000 -0400
@@ -64,7 +64,7 @@
 }
 
 EXPORT int
-getline(buf, len)
+_getline(buf, len)
 	char	*buf;
 	int	len;
 {
diff -Naur cdrtools-2.01/readcd/io.c cdrtools-2.01.patched/readcd/io.c
--- cdrtools-2.01/readcd/io.c	2002-12-25 09:13:28.000000000 -0500
+++ cdrtools-2.01.patched/readcd/io.c	2009-05-27 18:25:48.000000000 -0400
@@ -138,7 +138,7 @@
 		(*prt)(s, *lp, mini, maxi, dp);
 		flush();
 		line[0] = '\0';
-		if (getline(line, 80) == EOF)
+		if (_getline(line, 80) == EOF)
 			exit(EX_BAD);
 
 		linep = skipwhite(line);
@@ -205,7 +205,7 @@
 	printf("%r", form, args);
 	va_end(args);
 	flush();
-	if (getline(okbuf, sizeof(okbuf)) == EOF)
+	if (_getline(okbuf, sizeof(okbuf)) == EOF)
 		exit(EX_BAD);
 	if (okbuf[0] == '?') {
 		printf("Enter 'y', 'Y', 'yes' or 'YES' if you agree with the previous asked question.\n");
diff -Naur cdrtools-2.01/readcd/readcd.c cdrtools-2.01.patched/readcd/readcd.c
--- cdrtools-2.01/readcd/readcd.c	2004-09-08 13:24:14.000000000 -0400
+++ cdrtools-2.01.patched/readcd/readcd.c	2009-05-27 18:25:48.000000000 -0400
@@ -1651,7 +1651,7 @@
 		error("Copy from SCSI (%d,%d,%d) disk to file\n",
 					scg_scsibus(scgp), scg_target(scgp), scg_lun(scgp));
 		error("Enter filename [%s]: ", defname); flush();
-		(void) getline(filename, sizeof (filename));
+		(void) _getline(filename, sizeof (filename));
 	}
 
 	if (askrange) {
@@ -1820,7 +1820,7 @@
 		error("Copy from file to SCSI (%d,%d,%d) disk\n",
 					scg_scsibus(scgp), scg_target(scgp), scg_lun(scgp));
 		error("Enter filename [%s]: ", defname); flush();
-		(void) getline(filename, sizeof (filename));
+		(void) _getline(filename, sizeof (filename));
 		error("Notice: reading from file always starts at file offset 0.\n");
 
 		getlong("Enter starting sector for copy:", &addr, 0L, end-1);
diff -Naur cdrtools-2.01/scgcheck/dmaresid.c cdrtools-2.01.patched/scgcheck/dmaresid.c
--- cdrtools-2.01/scgcheck/dmaresid.c	2004-09-08 13:45:22.000000000 -0400
+++ cdrtools-2.01.patched/scgcheck/dmaresid.c	2009-05-27 18:25:48.000000000 -0400
@@ -64,7 +64,7 @@
 	printf("Ready to start test for working DMA residual count? Enter <CR> to continue: ");
 	fprintf(logfile, "**********> Testing for working DMA residual count.\n");
 	flushit();
-	(void) getline(abuf, sizeof (abuf));
+	(void) _getline(abuf, sizeof (abuf));
 
 	printf("**********> Testing for working DMA residual count == 0.\n");
 	fprintf(logfile, "**********> Testing for working DMA residual count == 0.\n");
@@ -95,7 +95,7 @@
 	printf("Ready to start test for working DMA residual count == DMA count? Enter <CR> to continue: ");
 	fprintf(logfile, "**********> Testing for working DMA residual count == DMA count.\n");
 	flushit();
-	(void) getline(abuf, sizeof (abuf));
+	(void) _getline(abuf, sizeof (abuf));
 	passed = TRUE;
 	dmacnt = cnt;
 	ret = xtinquiry(scgp, 0, dmacnt);
@@ -130,7 +130,7 @@
 	printf("Ready to start test for working DMA residual count == 1? Enter <CR> to continue: ");
 	fprintf(logfile, "**********> Testing for working DMA residual count == 1.\n");
 	flushit();
-	(void) getline(abuf, sizeof (abuf));
+	(void) _getline(abuf, sizeof (abuf));
 	passed = TRUE;
 	dmacnt = cnt+1;
 	ret = xtinquiry(scgp, cnt, dmacnt);
diff -Naur cdrtools-2.01/scgcheck/scgcheck.c cdrtools-2.01.patched/scgcheck/scgcheck.c
--- cdrtools-2.01/scgcheck/scgcheck.c	2004-09-08 13:49:48.000000000 -0400
+++ cdrtools-2.01.patched/scgcheck/scgcheck.c	2009-05-27 18:25:48.000000000 -0400
@@ -189,7 +189,7 @@
 			break;
 		error("Enter SCSI device name for bus scanning [%s]: ", device);
 		flushit();
-		(void) getline(device, sizeof (device));
+		(void) _getline(device, sizeof (device));
 		if (device[0] == '\0')
 			strcpy(device, "0,6,0");
 
@@ -227,7 +227,7 @@
 	do {
 		error("Enter SCSI device name [%s]: ", device);
 		flushit();
-		(void) getline(device, sizeof (device));
+		(void) _getline(device, sizeof (device));
 		if (device[0] == '\0')
 			strcpy(device, "0,6,0");
 
@@ -256,7 +256,7 @@
 
 	printf("Ready to start test for second SCSI open? Enter <CR> to continue: ");
 	flushit();
-	(void) getline(abuf, sizeof (abuf));
+	(void) _getline(abuf, sizeof (abuf));
 #define	CHECK_SECOND_OPEN
 #ifdef	CHECK_SECOND_OPEN
 	if (!streql(abuf, "n")) {
@@ -344,7 +344,7 @@
 
 	printf("Ready to start test for succeeded command? Enter <CR> to continue: ");
 	flushit();
-	(void) getline(abuf, sizeof (abuf));
+	(void) _getline(abuf, sizeof (abuf));
 	scgp->verbose++;
 	ret = inquiry(scgp, buf, sizeof (struct scsi_inquiry));
 	scg_vsetup(scgp);
diff -Naur cdrtools-2.01/scgcheck/sense.c cdrtools-2.01.patched/scgcheck/sense.c
--- cdrtools-2.01/scgcheck/sense.c	2003-03-27 05:59:52.000000000 -0500
+++ cdrtools-2.01.patched/scgcheck/sense.c	2009-05-27 18:25:48.000000000 -0400
@@ -66,7 +66,7 @@
 	printf("Ready to start test for failing command? Enter <CR> to continue: ");
 	fprintf(logfile, "**********> Testing for failed SCSI command.\n");
 	flushit();
-	(void)getline(abuf, sizeof(abuf));
+	(void)_getline(abuf, sizeof(abuf));
 /*	scgp->verbose++;*/
 	fillbytes(buf, sizeof(struct scsi_inquiry), '\0');
 	fillbytes((caddr_t)scgp->scmd, sizeof(*scgp->scmd), '\0');
@@ -82,13 +82,13 @@
 		printf("the test utility. Otherwise remove any medium from the drive.\n");
 		printf("Ready to start test for failing command? Enter <CR> to continue: ");
 		flushit();
-		(void)getline(abuf, sizeof(abuf));
+		(void)_getline(abuf, sizeof(abuf));
 		ret = test_unit_ready(scgp);
 		if (ret >= 0 || !scg_cmd_err(scgp)) {
 			printf("Test Unit Ready did not fail.\n");
 			printf("Ready to eject tray? Enter <CR> to continue: ");
 			flushit();
-			(void)getline(abuf, sizeof(abuf));
+			(void)_getline(abuf, sizeof(abuf));
 			scsi_unload(scgp, (cdr_t *)0);
 			ret = test_unit_ready(scgp);
 		}
@@ -127,7 +127,7 @@
 	printf("Ready to start test for sense data count? Enter <CR> to continue: ");
 	fprintf(logfile, "**********> Testing for SCSI sense data count.\n");
 	flushit();
-	(void)getline(abuf, sizeof(abuf));
+	(void)_getline(abuf, sizeof(abuf));
 	printf("Testing if at least CCS_SENSE_LEN (%d) is supported...\n", CCS_SENSE_LEN);
 	fprintf(logfile, "**********> Testing if at least CCS_SENSE_LEN (%d) is supported...\n", CCS_SENSE_LEN);
 	ret = sensecount(scgp, CCS_SENSE_LEN);
EOF
  make INS_BASE=/usr DEFINSUSR=root DEFINSGRP=root CC="$CC $BUILD" \
    CXX="$CXX $BUILD" || return 1
  make INS_BASE=$TMPROOT/usr DEFINSUSR=root DEFINSGRP=root install || return 1
  if [ ! -d "$TMPROOT/usr/$LIBSDIR" ]; then
    mv $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.berlios.de/pub/cdrecord/'
  VERSION_STRING='cdrtools-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.berlios.de/pub/cdrecord/cdrtools-%version%.tar.bz2'
  )
}
