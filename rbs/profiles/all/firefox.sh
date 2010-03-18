#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.6"
SYS_VERSION="3.6-1"

DIR="firefox-${VERSION}"
TARBALL="firefox-${VERSION}.source.tar.bz2"

DEPENDS=(
  curl
  desktop-file-utils
  libidl
  libnotify
)

SRC1=(
http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${VERSION}/source/${TARBALL}
)

MD5SUMS=(
458051557ff49e6a352c1d56eee5782a
)

build(){
  local OSTEST
  unset CFLAGS CXXFLAGS
  OSTEST=$(gcc -dumpmachine | cut -f1 -d'-')
  
  mkdir -p $SRCDIR/$DIR || return 1
  echo -n "Unpacking ${TARBALL}..."
  tar xfj $DOWNLOADDIR/$TARBALL -C $SRCDIR/$DIR/ || return 1
  echo " Done."
  cd $SRCDIR/$DIR/mozilla* || return 1

cat > .mozconfig << EOF
. \$topsrcdir/browser/config/mozconfig
mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-@CONFIG_GUESS@

ac_cv_visibility_pragma=no

ac_add_options --prefix=/usr

ac_add_options --with-system-zlib
ac_add_options --with-system-jpeg
ac_add_options --enable-system-cairo

ac_add_options --enable-canvas
ac_add_options --enable-svg

ac_add_options --enable-strip
ac_add_options --disable-tests 
ac_add_options --disable-accessibility
ac_add_options --disable-installer 
ac_add_options --enable-official-branding
ac_add_options --enable-xinerama

ac_add_options --enable-single-profile
ac_add_options --disable-profilesharing

ac_add_options --disable-gnomevfs
ac_add_options --disable-gnomeui

ac_add_options --disable-crashreporter

ac_add_options --disable-necko-wifi

ac_add_options --with-default-mozilla-five-home=/usr/${LIBSDIR}/firefox-${VERSION}
export CC="gcc ${BUILD}"
export CXX="g++ ${BUILD}"
ac_add_options --libdir=/usr/${LIBSDIR}
EOF

  if [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ]; then
cat >> .mozconfig << EOF
ac_add_options --host=$BUILDTARGET
ac_add_options --build=$BUILDTARGET
mk_add_options CONFIG_GUESS=$BUILDTARGET
EOF
    OSTEST=$(echo $BUILDTARGET | cut -f1 -d'-')
  fi
  
  sed -i "s:@MOZ_GTK2_LIBS@:& -L/usr/${LIBSDIR} -lX11 -lXrender:g" \
    config/autoconf.mk.in || return 1
  make -f client.mk OS_TEST=$OSTEST build || return 1
  make -f client.mk OS_TEST=$OSTEST install DESTDIR=$TMPROOT || return 1
  
  set_multiarch $TMPROOT/usr/bin/firefox-config || return 1
  
cat << "EOF" > $TMPROOT/usr/$LIBSDIR/firefox-${VERSION}/defaults/profile/prefs.js || return 1
# Mozilla User Preferences
 /* Do not edit this file.
 *
 * If you make changes to this file while the browser is running,
 * the changes will be overwritten when the browser exits.
 *
 * To make a manual change to preferences, you can visit the URL about:config
 * For more information, see http://www.mozilla.org/unix/customizing.html#prefs
 */

user_pref("extensions.disabledObsolete", true);
user_pref("font.default", "sans-serif");
user_pref("font.minimum-size.x-western", 11);
user_pref("font.name.monospace.x-western", "monospace");
user_pref("font.name.sans-serif.x-western", "sans-serif");
user_pref("font.name.serif.x-western", "sans-serif");
user_pref("font.size.variable.x-western", 12);
user_pref("network.protocol-handler.app.mailto","thunderbird");
EOF
  
  mkdir -p $TMPROOT/usr/share/applications || return 1
cat << EOF > $TMPROOT/usr/share/applications/firefox.desktop || return 1
[Desktop Entry]
Name=Browser
Comment=Browser
Exec=/usr/bin/firefox
StartupNotify=false
Icon=/usr/$LIBSDIR/firefox-${VERSION}/icons/mozicon128.png
Terminal=0
Type=Application
Categories=Application;Network;
EOF

  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/%version%/source/'
  VERSION_STRING='firefox-%version%.source.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/%version%/source/firefox-%version%-source.tar.bz2'
    'http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/%version%/source/firefox-%version%-source.tar.bz2'
  )
}
