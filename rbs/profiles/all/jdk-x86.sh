#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6u18"

ONLY32=1

TARBALL="jdk-${VERSION}-dlj-linux-i586.bin"

DEPENDS=(
  alsa-lib
  libxi
  libxt
  libxtst
)

SRC1=(
http://dlc.sun.com/dlj/binaries/$TARBALL
)

MD5SUMS=(
38ebeb49b85668b56305409db2e2eb6a
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
  local DIR
  mkdir -p $TMPROOT/usr/$LIBSDIR $SRCDIR/jdk || return 1
  cd $SRCDIR/jdk || return 1
  sh $DOWNLOADDIR/$TARBALL --accept-license --unpack || return 1
  cd * || return 1
  DIR=$PWD
  cd ../ || return 1
  mv $DIR $TMPROOT/usr/$LIBSDIR/jdk || return 1
  mv $TMPROOT/usr/$LIBSDIR/jdk/include $TMPROOT/usr/ || return 1
  mkdir -p $TMPROOT/etc/profile.d
cat << EOF > $TMPROOT/etc/profile.d/jdk.sh
PATH=\$PATH:/usr/$LIBSDIR/jdk/bin:/usr/$LIBSDIR/jdk/jre/bin

if [ -z "\$MOZ_PLUGIN_PATH" ]; then
  MOZ_PLUGIN_PATH=/usr/$LIBSDIR/jdk/jre/plugin/i386/ns7
else
  MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH:/usr/$LIBSDIR/jdk/jre/plugin/i386/ns7
fi

if [ -z "\$MANPATH" ]; then
  MANPATH=/usr/$LIBSDIR/jdk/man
else
  MANPATH=\$MANPATH:/usr/$LIBSDIR/jdk/man
fi

export PATH MOZ_PLUGIN_PATH MANPATH
EOF
  chmod 755 $TMPROOT/etc/profile.d/jdk.sh || return 1
  source $TMPROOT/etc/profile.d/jdk.sh || return 1
  cd $SRCDIR || return 1
  rm -rf jdk || return 1
}

#version_check_info(){
#  ADDRESS='http://jdk-distros.dev.java.net/developer.html'
#  VERSION_STRING='jdk-%version%-dlj-linux-i586.bin'
#  MIRRORS=(
#    'http://dlc.sun.com/dlj/binaries/jdk-%version%-dlj-linux-i586.bin'
#  )
#}

