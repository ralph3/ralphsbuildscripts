#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.33.2"
SYS_VERSION="2.6.33.2-1"

DIR="linux-${VERSION}"
TARBALL="linux-${VERSION}.tar.bz2"

DEPENDS=(
  linux-headers
  mktemp
  module-init-tools
)

SRC1=(
http://www.kernel.org/pub/linux/kernel/v2.6/${TARBALL}
)

MD5SUMS=(
80c5ff544b0ee4d9b5d8b8b89d4a0ef9
)

source_setup(){
  if [ "$VERSION" != "$(uname -r)" ]; then
    echo "VERSION=$VERSION but running kernel is version $(uname -r)!"
    echo "If you just upgraded your kernel, reboot before setting up the source."
    return 1
  fi
  if [ ! -d "$SRCDIR/$DIR" ]; then
    mkdir -p $SRCDIR || return 1
    echo -n "Unpacking ${TARBALL}..."
    tar xfj $DOWNLOADDIR/$TARBALL -C $SRCDIR || return 1
    echo "Done."
  fi
  cd $SRCDIR/$DIR || return 1
  make mrproper || return 1
  cp $(grep /boot/ /var/lib/packages/current/linux/filelist | grep config | sed q) .config || return 1
  sed -i "s%/lib/modules%/${LIBSDIR}/modules%g" $(grep -rl "/lib/modules" *)
  make scripts || return 1
  make prepare || return 1
  ln -sfn $SRCDIR/$DIR /$LIBSDIR/modules/$(uname -r)/build || return 1
  ln -sfn $SRCDIR/$DIR /$LIBSDIR/modules/$(uname -r)/source || return 1
  cd $SRCDIR || return 1
}

RBS_Tools_Build(){
  local KARCH KCONF MODDIR KNAME
  case $($CC -dumpmachine | cut -f1 -d'-') in
    i486|i586|i686)
      KARCH=i386
      KCONF="x86-kernel.config"
    ;;
    x86_64)
      KARCH=x86_64
      KCONF="x86_64-kernel.config"
    ;;
    *)
      echo "error not ready for this arch!"
      return 1
    ;;
  esac
  if [ -e "$CONFDIR/$KCONF" ]; then
    KCONF="$CONFDIR/$KCONF"
    echo "Using custom kernel config. ($(basename ${KCONF}))"
  else
    if [ -e "$CONFDIR/${KCONF}.default" ]; then
      KCONF="$CONFDIR/${KCONF}.default"
      echo "Using default kernel config. ($(basename ${KCONF}))"
    else
      echo "No kernel config found in CONFDIR!" >/dev/stderr
      return 1
    fi
  fi
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make mrproper || return 1
  sed '/=m/d' $KCONF > .config || return 1
  sed -i "s%/lib/modules%/${LIBSDIR}/modules%g" $(grep -rl "/lib/modules" *) || return 1
  yes "" | make ARCH=$KARCH CROSS_COMPILE=${BUILDTARGET}- oldconfig || return 1
  make ARCH=$KARCH CROSS_COMPILE=${BUILDTARGET}- || return 1
  mkdir -p $ROOT/boot || return 1
  KNAME=$(basename $KCONF | cut -f1 -d'.')-${VERSION}
  cp -v arch/$KARCH/boot/bzImage ${ROOT}/boot/$KNAME || return 1
  ln -vsfn $KNAME ${ROOT}/boot/vmlinuz || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  local KARCH KCONF MODDIR KNAME
  case $($CC -dumpmachine | cut -f1 -d'-') in
    i486|i586|i686)
      KARCH=i386
      KCONF="x86-kernel.config"
    ;;
    x86_64)
      KARCH=x86_64
      KCONF="x86_64-kernel.config"
    ;;
    *)
      echo "error not ready for this arch!"
      return 1
    ;;
  esac
  if [ -e "$CONFDIR/$KCONF" ]; then
    KCONF="$CONFDIR/$KCONF"
    echo "Using custom kernel config. ($(basename ${KCONF}))"
  else
    if [ -e "$CONFDIR/${KCONF}.default" ]; then
      KCONF="$CONFDIR/${KCONF}.default"
      echo "Using default kernel config. ($(basename ${KCONF}))"
    else
      echo "No kernel config found in CONFDIR!" >/dev/stderr
      return 1
    fi
  fi
  if [ ! -d "$HDSRCDIR/$DIR" ]; then
    mkdir -p $HDSRCDIR || return 1
    echo -n "Unpacking ${TARBALL}..."
    tar xfj $DOWNLOADDIR/$TARBALL -C $HDSRCDIR || return 1
    echo "Done."
  fi
  cd $HDSRCDIR/$DIR || return 1
  make mrproper || return 1
  cp $KCONF .config || return 1
  
  sed -i "s%/lib/modules%/${LIBSDIR}/modules%g" $(grep -rl "/lib/modules" *) || return 1
  
  yes "" | make oldconfig || return 1
  make || return 1
  make INSTALL_MOD_PATH=$TMPROOT modules_install || return 1
  
  MODDIR="${TMPROOT}/$LIBSDIR/modules/$(uname -r)/"
  find $TMPROOT -type f -name '*.ko' | while read mod; do
    echo "gzip: $(echo $mod | sed "s%^${MODDIR}%%")"
    strip --strip-unneeded $mod >& /dev/null
    gzip -9 $mod
    mv -f ${mod}.gz ${mod}
  done
  mkdir -p $TMPROOT/boot || return 1
  KNAME=$(basename $KCONF | cut -f1 -d'.')-${VERSION}
  cp -v arch/$KARCH/boot/bzImage $TMPROOT/boot/$KNAME || return 1
  ln -vsfn $KNAME $TMPROOT/boot/vmlinuz || return 1
  cp -v System.map $TMPROOT/boot/${KNAME}-System.map || return 1
  cp -v .config $TMPROOT/boot/${KNAME}.config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/kernel/v%minor_version%/'
  VERSION_STRING='linux-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://www.kernel.org/pub/linux/kernel/v%minor_version%/linux-%version%.tar.bz2'
  )
}