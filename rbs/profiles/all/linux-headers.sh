#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.33.2"

DIR="linux-${VERSION}"
TARBALL="linux-${VERSION}.tar.bz2"

DEPENDS=(
  filesystem
)

SRC1=(
http://www.kernel.org/pub/linux/kernel/v2.6/${TARBALL}
)

MD5SUMS=(
80c5ff544b0ee4d9b5d8b8b89d4a0ef9
)

Cross_Tools_Build(){
  local KARCH KCONF MODDIR
  case $(echo $BUILDTARGET | cut -f1 -d'-') in
    i?86)
      KARCH=i386
    ;;
    x86_64)
      KARCH=x86_64
    ;;
    *)
      echo "error not ready for this arch!"
      return 1
    ;;
  esac
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  mkdir -vp $TCDIR/include || return 1
  make mrproper || return 1
  make ARCH=$KARCH headers_check || return 1
  make ARCH=$KARCH INSTALL_HDR_PATH=$TCDIR headers_install || return 1
  find $TCDIR/include -type d -exec chmod -v 755 {} \;
  find $TCDIR/include -type f -exec chmod -v 644 {} \;
  sed -i 's/\tu8/\t__u8/' $TCDIR/include/scsi/scsi.h || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  local KARCH KCONF MODDIR
  case $($CC -dumpmachine | cut -f1 -d'-') in
    i?86)
      KARCH=i386
    ;;
    x86_64)
      KARCH=x86_64
    ;;
    *)
      echo "error not ready for this arch!"
      return 1
    ;;
  esac
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  make mrproper || return 1
  make ARCH=$KARCH headers_check || return 1
  make ARCH=$KARCH INSTALL_HDR_PATH=$TMPROOT/usr headers_install || return 1
  find $TMPROOT -type d -exec chmod -v 755 {} \;
  find $TMPROOT -type f -exec chmod -v 644 {} \;
  sed -i 's/\tu8/\t__u8/' $TMPROOT/usr/include/scsi/scsi.h || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

