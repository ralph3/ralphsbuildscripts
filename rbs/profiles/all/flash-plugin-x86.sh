#!/bin/bash

DISABLE_MULTILIB=1

VERSION="10"

ONLY32=1

DEPENDS=(
  curl
)

DIR="install_flash_player_10_linux"
TARBALL="install_flash_player_10_linux.tar.gz"

SRC1=(
http://ralphsbuildscripts.googlecode.com/files/$TARBALL
)

MD5SUMS=(
23e4c2b844db0f87ff62084178aa2b1f
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
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
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
