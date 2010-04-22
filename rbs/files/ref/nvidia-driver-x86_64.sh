#!/bin/bash

DISABLE_MULTILIB=1

VERSION="195.36.15-pkg2"

DISABLE_STRIP=1

TARBALL="NVIDIA-Linux-x86_64-${VERSION}.run"
DIR="NVIDIA-Linux-x86_64-${VERSION}"

DEPENDS=(
  desktop-file-utils
  xorg-server
)

SRC1=(
http://download.nvidia.com/XFree86/Linux-x86_64/$(echo $VERSION | cut -f-1 -d'-')/$TARBALL
ftp://download.nvidia.com/XFree86/Linux-x86_64/$(echo $VERSION | cut -f-1 -d'-')/$TARBALL
)

MD5SUMS=(
f52324869e20b3990eed74be48c7fe46
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
  $RBSDIR/setup-source linux || return 1
  local MAJOR MINOR PATCH REV DOCDIR
  mkdir -p $SRCDIR || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
  chmod 744 $DOWNLOADDIR/${DIR}.run || return 1
  $DOWNLOADDIR/${DIR}.run --extract-only || return 1
  chmod 644 $DOWNLOADDIR/${DIR}.run || return 1
  
  cd $DIR || return 1
  
  sed -i "s%/lib/modules%/${LIBSDIR}/modules%g" $(grep -rl "/lib/modules" *) || return 1
  
  cd usr/src/nv || return 1
  for f in Makefile.kbuild Makefile.nvidia; do
    sed -i 's%modprobe%true%g;s%sh makedevices.sh%@true%g' $f || return 1
    sed -i 's%depmod%true%g;s%-o root -g root%%g' $f || return 1
  done
  sed -i 's%rmmod_sanity_check)%foo1)%' conftest.sh || return 1
  sed -i 's%suser_sanity_check)%foo2)%' conftest.sh || return 1
  
  make MODULE_ROOT=$TMPROOT/$LIBSDIR/modules/$(uname -r)/kernel/drivers install || return 1
  gzip -v9 $TMPROOT/$LIBSDIR/modules/$(uname -r)/kernel/drivers/video/nvidia.ko || return 1
  mv $TMPROOT/$LIBSDIR/modules/$(uname -r)/kernel/drivers/video/nvidia.ko.gz \
    $TMPROOT/$LIBSDIR/modules/$(uname -r)/kernel/drivers/video/nvidia.ko || return 1
  
  REV=$(echo $VERSION | cut -f1 -d'-')
  DOCDIR="/usr/share/doc/nvidia"
  
  cd $SRCDIR/$DIR
  
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    mkdir -pv $TMPROOT/usr/$LIBSDIR32 || return 1
    
    install -vm 0755 usr/lib32/libGL.so.${REV} \
      $TMPROOT/usr/$LIBSDIR32 || return 1
    ln -vsf libGL.so.${REV} \
      $TMPROOT/usr/$LIBSDIR32/libGL.so || return 1
    
    install -vm 0755 usr/lib32/libGLcore.so.${REV} \
      $TMPROOT/usr/$LIBSDIR32 || return 1
    
    install -vm 0755 usr/lib32/libnvidia-tls.so.${REV} \
      $TMPROOT/usr/$LIBSDIR32 || return 1
    
    usr/bin/tls_test usr/bin/tls_test_dso.so 2>/dev/null && {
      mkdir -pv $TMPROOT/usr/$LIBSDIR32/tls || return 1
      install -vm 0755 usr/lib32/tls/libnvidia-tls.so.${REV} \
        $TMPROOT/usr/$LIBSDIR32/tls || return 1
    }
  fi
  
  mkdir -vp $TMPROOT/usr/$LIBSDIR
  install -vm 0755 usr/lib/libGL.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  ln -vsf libGL.so.${REV} $TMPROOT/usr/$LIBSDIR/libGL.so || return 1
  
  install -vm 0755 usr/lib/libGLcore.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  
  mkdir -vp $TMPROOT/usr/$LIBSDIR/X11/modules/{drivers,extensions} || return 1
  
  install -vm 0755 usr/X11R6/lib/modules/drivers/nvidia_drv.so \
    $TMPROOT/usr/$LIBSDIR/X11/modules/drivers || return 1

  install -vm 0755 usr/X11R6/lib/modules/extensions/libglx.so.${REV} \
    $TMPROOT/usr/$LIBSDIR/X11/modules/extensions || return 1
  ln -vsf libglx.so.${REV} \
    $TMPROOT/usr/$LIBSDIR/X11/modules/extensions/libglx.so || return 1

  install -vm 0755 usr/lib/libnvidia-tls.so.${REV} \
    $TMPROOT/usr/$LIBSDIR || return 1
  
  usr/bin/tls_test usr/bin/tls_test_dso.so 2>/dev/null && {
    mkdir -pv $TMPROOT/usr/$LIBSDIR/tls
    install -vm 0755 usr/lib/tls/libnvidia-tls.so.${REV} \
      $TMPROOT/usr/$LIBSDIR/tls || return 1
  }
  
  
  install -vm 0755 usr/X11R6/lib/libXvMCNVIDIA.so.${REV} \
    $TMPROOT/usr/$LIBSDIR || return 1
  
  mkdir -pv $TMPROOT/$DOCDIR $TMPROOT/usr/{bin,share/applications} \
    $TMPROOT/usr/share/man/man1 || return 1
  
  cp -av usr/share/doc/* $TMPROOT/$DOCDIR || return 1
  cp -av usr/share/pixmaps $TMPROOT/usr/share/ || return 1
  
  for x in nvidia-settings nvidia-xconfig; do
    install -vm 0755 usr/bin/$x $TMPROOT/usr/bin/ || exit 1
    zcat usr/share/man/man1/${x}.1.gz > \
      $TMPROOT/usr/share/man/man1/${x}.1 || exit 1
  done

  sed "s%__UTILS_PATH__%/usr/bin%;s%__PIXMAP_PATH__%/usr/share/pixmaps%" \
    usr/share/applications/nvidia-settings.desktop > \
    $TMPROOT/usr/share/applications/nvidia-settings.desktop || exit 1
  
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

pre_install(){
  rm -f /usr/lib/libGL.*
}

pre_upgrade(){
  pre_install
}

post_install(){
  update-desktop-database -q || return 1
  depmod -a || return 1
}

post_upgrade(){
  post_install || return 1
}
