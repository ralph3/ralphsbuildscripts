#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.1"
SYS_VERSION="1.3.1-3"

DIR="synergy-${VERSION}"
TARBALL="synergy-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/synergy2/${TARBALL}
)

MD5SUMS=(
a6e09d6b71cb217f23069980060abf27
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1

cat << "EOF" | patch -Np1 || return 1
diff -Naur synergy-1.3.1/lib/arch/CArchDaemonUnix.cpp synergy-1.3.1.patched/lib/arch/CArchDaemonUnix.cpp
--- synergy-1.3.1/lib/arch/CArchDaemonUnix.cpp	2005-04-23 23:02:12.000000000 -0400
+++ synergy-1.3.1.patched/lib/arch/CArchDaemonUnix.cpp	2009-05-13 22:02:43.000000000 -0400
@@ -19,6 +19,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <cstdlib>
 
 //
 // CArchDaemonUnix
diff -Naur synergy-1.3.1/lib/arch/CMultibyte.cpp synergy-1.3.1.patched/lib/arch/CMultibyte.cpp
--- synergy-1.3.1/lib/arch/CMultibyte.cpp	2005-11-29 23:33:24.000000000 -0500
+++ synergy-1.3.1.patched/lib/arch/CMultibyte.cpp	2009-05-13 22:05:47.000000000 -0400
@@ -19,14 +19,13 @@
 #include "CArch.h"
 #include <limits.h>
 #include <string.h>
+#include <cstdlib>
+
 #if HAVE_LOCALE_H
 #	include <locale.h>
 #endif
 #if HAVE_WCHAR_H || defined(_MSC_VER)
 #	include <wchar.h>
-#elif __APPLE__
-	// wtf?  Darwin puts mbtowc() et al. in stdlib
-#	include <stdlib.h>
 #else
 	// platform apparently has no wchar_t support.  provide dummy
 	// implementations.  hopefully at least the C++ compiler has
diff -Naur synergy-1.3.1/lib/base/CStringUtil.cpp synergy-1.3.1.patched/lib/base/CStringUtil.cpp
--- synergy-1.3.1/lib/base/CStringUtil.cpp	2005-12-14 12:25:20.000000000 -0500
+++ synergy-1.3.1.patched/lib/base/CStringUtil.cpp	2009-05-13 22:06:16.000000000 -0400
@@ -19,6 +19,7 @@
 #include <cctype>
 #include <cstdio>
 #include <cstdlib>
+#include <cstring>
 #include <algorithm>
 
 //
diff -Naur synergy-1.3.1/lib/client/CClient.cpp synergy-1.3.1.patched/lib/client/CClient.cpp
--- synergy-1.3.1/lib/client/CClient.cpp	2006-03-08 23:07:17.000000000 -0500
+++ synergy-1.3.1.patched/lib/client/CClient.cpp	2009-05-13 22:06:49.000000000 -0400
@@ -26,6 +26,8 @@
 #include "CLog.h"
 #include "IEventQueue.h"
 #include "TMethodEventJob.h"
+#include <cstring>
+#include <cstdlib>
 
 //
 // CClient
diff -Naur synergy-1.3.1/lib/client/CServerProxy.cpp synergy-1.3.1.patched/lib/client/CServerProxy.cpp
--- synergy-1.3.1/lib/client/CServerProxy.cpp	2006-04-01 20:47:03.000000000 -0500
+++ synergy-1.3.1.patched/lib/client/CServerProxy.cpp	2009-05-13 22:07:08.000000000 -0400
@@ -24,6 +24,7 @@
 #include "TMethodEventJob.h"
 #include "XBase.h"
 #include <memory>
+#include <cstring>
 
 //
 // CServerProxy
diff -Naur synergy-1.3.1/lib/net/CTCPSocket.cpp synergy-1.3.1.patched/lib/net/CTCPSocket.cpp
--- synergy-1.3.1/lib/net/CTCPSocket.cpp	2006-04-01 20:47:03.000000000 -0500
+++ synergy-1.3.1.patched/lib/net/CTCPSocket.cpp	2009-05-13 22:07:31.000000000 -0400
@@ -24,6 +24,7 @@
 #include "CArch.h"
 #include "XArch.h"
 #include <string.h>
+#include <cstdlib>
 
 //
 // CTCPSocket
diff -Naur synergy-1.3.1/lib/platform/CXWindowsScreen.cpp synergy-1.3.1.patched/lib/platform/CXWindowsScreen.cpp
--- synergy-1.3.1/lib/platform/CXWindowsScreen.cpp	2006-04-02 15:16:39.000000000 -0400
+++ synergy-1.3.1.patched/lib/platform/CXWindowsScreen.cpp	2009-05-13 22:08:13.000000000 -0400
@@ -27,6 +27,7 @@
 #include "IEventQueue.h"
 #include "TMethodEventJob.h"
 #include <cstring>
+#include <cstdlib>
 #if X_DISPLAY_MISSING
 #	error X11 is required to build synergy
 #else
diff -Naur synergy-1.3.1/lib/server/CClientProxy1_3.cpp synergy-1.3.1.patched/lib/server/CClientProxy1_3.cpp
--- synergy-1.3.1/lib/server/CClientProxy1_3.cpp	2006-02-12 14:53:43.000000000 -0500
+++ synergy-1.3.1.patched/lib/server/CClientProxy1_3.cpp	2009-05-13 22:08:50.000000000 -0400
@@ -17,7 +17,7 @@
 #include "CLog.h"
 #include "IEventQueue.h"
 #include "TMethodEventJob.h"
-
+#include <cstring>
 //
 // CClientProxy1_3
 //
diff -Naur synergy-1.3.1/lib/server/CServer.cpp synergy-1.3.1.patched/lib/server/CServer.cpp
--- synergy-1.3.1/lib/server/CServer.cpp	2006-04-01 20:47:04.000000000 -0500
+++ synergy-1.3.1.patched/lib/server/CServer.cpp	2009-05-13 22:09:21.000000000 -0400
@@ -28,7 +28,8 @@
 #include "CLog.h"
 #include "TMethodEventJob.h"
 #include "CArch.h"
-#include <string.h>
+#include <cstring>
+#include <cstdlib>
 
 //
 // CServer
diff -Naur synergy-1.3.1/lib/synergy/CPacketStreamFilter.cpp synergy-1.3.1.patched/lib/synergy/CPacketStreamFilter.cpp
--- synergy-1.3.1/lib/synergy/CPacketStreamFilter.cpp	2005-04-23 23:02:16.000000000 -0400
+++ synergy-1.3.1.patched/lib/synergy/CPacketStreamFilter.cpp	2009-05-13 22:09:51.000000000 -0400
@@ -16,6 +16,7 @@
 #include "IEventQueue.h"
 #include "CLock.h"
 #include "TMethodEventJob.h"
+#include <cstring>
 
 //
 // CPacketStreamFilter
diff -Naur synergy-1.3.1/lib/synergy/IKeyState.cpp synergy-1.3.1.patched/lib/synergy/IKeyState.cpp
--- synergy-1.3.1/lib/synergy/IKeyState.cpp	2006-03-22 00:40:27.000000000 -0500
+++ synergy-1.3.1.patched/lib/synergy/IKeyState.cpp	2009-05-13 22:10:20.000000000 -0400
@@ -13,7 +13,8 @@
  */
 
 #include "IKeyState.h"
-#include <string.h>
+#include <cstring>
+#include <cstdlib>
 
 //
 // IKeyState
diff -Naur synergy-1.3.1/lib/synergy/IPrimaryScreen.cpp synergy-1.3.1.patched/lib/synergy/IPrimaryScreen.cpp
--- synergy-1.3.1/lib/synergy/IPrimaryScreen.cpp	2006-03-22 00:40:27.000000000 -0500
+++ synergy-1.3.1.patched/lib/synergy/IPrimaryScreen.cpp	2009-05-13 22:10:56.000000000 -0400
@@ -14,6 +14,8 @@
 
 #include "IPrimaryScreen.h"
 
+#include <cstdlib>
+
 //
 // IPrimaryScreen
 //
EOF

  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
cat << "EOF" > $TMPROOT/usr/bin/synergy-server || return 1
#!/bin/bash

synergys --config /etc/synergy.conf --daemon --restart
EOF
  chmod 755 $TMPROOT/usr/bin/synergy-server || return 1
  
  mkdir -p $TMPROOT/etc || return 1
cat << "EOF" > $TMPROOT/etc/synergy.conf.new || return 1
section: screens
SERVERHOSTNAME:
CLIENTHOSTNAME:
end

section: links
SERVERHOSTNAME:
right = CLIENTHOSTNAME
CLIENTHOSTNAME:
left = SERVERHOSTNAME
end

section: options
screenSaverSync = false
keystroke(f12) = lockCursorToScreen(toggle)
end
EOF
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=59275&package_id=58007'
  VERSION_STRING='synergy-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/synergy2/synergy-%version%.tar.gz"
  )
}