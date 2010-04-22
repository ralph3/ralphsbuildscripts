#!/bin/bash

DISABLE_MULTILIB=1

VERSION="10.0.45.2"

DEPENDS=(
  gtk+
  curl
)

DIR="libflashplayer-${VERSION}.linux-x86_64.so"
TARBALL="libflashplayer-${VERSION}.linux-x86_64.so.tar.gz"

SRC1=(
http://ralphsbuildscripts.googlecode.com/files/$TARBALL
)

MD5SUMS=(
4a4561e456612a6751653b58342d53df
)

build(){
  check_my_arch(){
    case $($CC -dumpmachine | cut -f1 -d'-') in
      x86_64)
        return 0
      ;;
    esac
    echo "I can only be installed on x86_64!"
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