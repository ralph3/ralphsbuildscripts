#!/bin/bash

DISABLE_MULTILIB=1

VERSION="10.0.45.2"
SYS_VERSION="10.0.45.2-1"

ONLY32=1

DEPENDS=(
  gtk+
  curl
)

DIR="libflashplayer-${VERSION}.linux-x86.so"
TARBALL="libflashplayer-${VERSION}.linux-x86.so.tar.gz"

SRC1=(
http://ralphsbuildscripts.googlecode.com/files/$TARBALL
)

MD5SUMS=(
dbfc776cd4310250cde078e0bf0472e7
)

build(){
  check_my_arch(){
    case $($CC -dumpmachine | cut -f1 -d'-') in
      i?86|x86_64)
        if [ "$SYSTYPE" != "64BIT" ]; then
          return 0
        fi
      ;;
    esac
    echo "I can only be installed on x86 or x86_64-32BIT!"
    return 1
  }
  check_my_arch || return 1
  mkdir -p $SRCDIR/$DIR || return 1
  cd $SRCDIR/$DIR || return 1
  
  tar xfz $DOWNLOADDIR/$TARBALL || return 1
  
  mkdir -vp $TMPROOT/usr/$LIBSDIR/flash-plugin || return 1
  cp -v $SRCDIR/$DIR/*.so $TMPROOT/usr/$LIBSDIR/flash-plugin/ || return 1
  mkdir -p $TMPROOT/etc/profile.d
cat << EOF > $TMPROOT/etc/profile.d/flash-plugin.sh
if [ -z "\$MOZ_PLUGIN_PATH" ]; then
  MOZ_PLUGIN_PATH=/usr/$LIBSDIR/flash-plugin
else
  MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH:/usr/$LIBSDIR/flash-plugin
fi
export MOZ_PLUGIN_PATH
EOF
  chmod 755 $TMPROOT/etc/profile.d/flash-plugin.sh || exit 1
  source $TMPROOT/etc/profile.d/flash-plugin.sh || exit 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
