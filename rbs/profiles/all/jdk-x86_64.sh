#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6u19"
SYS_VERSION="6u19-1"

TARBALL="jdk-${VERSION}-dlj-linux-amd64.bin"

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
a828c0bc26474060d7514b8948819b8b
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
  local DIR
  mkdir -p $TMPROOT/usr/$LIBSDIR $SRCDIR/jdk || return 1
  cd $SRCDIR/jdk || return 1
  sh $DOWNLOADDIR/$TARBALL --accept-license --unpack || return 1
  cd * || return 1
  DIR=$PWD
  cd ../ || return 1
  mv $DIR $TMPROOT/usr/$LIBSDIR/jdk || return 1
  mv $TMPROOT/usr/$LIBSDIR/jdk/include $TMPROOT/usr/ || return 1
  mkdir -p $TMPROOT/etc/{ld.so.conf,profile}.d

cat << EOF > $TMPROOT/etc/ld.so.conf.d/jdk.conf
/usr/$LIBSDIR/jdk/jre/lib/amd64
/usr/$LIBSDIR/jdk/jre/lib/amd64/jli
/usr/$LIBSDIR/jdk/jre/lib/amd64/motif21
/usr/$LIBSDIR/jdk/jre/lib/amd64/native_threads
/usr/$LIBSDIR/jdk/jre/lib/amd64/server
/usr/$LIBSDIR/jdk/jre/lib/amd64/xawt
EOF

cat << EOF > $TMPROOT/etc/profile.d/jdk.sh
PATH=\$PATH:/usr/$LIBSDIR/jdk/bin:/usr/$LIBSDIR/jdk/jre/bin

if [ -z "\$MOZ_PLUGIN_PATH" ]; then
  MOZ_PLUGIN_PATH=/usr/$LIBSDIR/jdk/jre/lib/amd64
else
  MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH:/usr/$LIBSDIR/jdk/jre/lib/amd64
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

