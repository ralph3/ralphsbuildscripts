#!/bin/bash

DISABLE_MULTILIB=1

VERSION="190.53-pkg1"

DISABLE_STRIP=1

TARBALL="NVIDIA-Linux-x86-${VERSION}.run"
DIR="NVIDIA-Linux-x86-${VERSION}"

DEPENDS=(
  desktop-file-utils
  linux
  xorg-server
)

SRC1=(
http://us.download.nvidia.com/XFree86/Linux-x86/$(echo $VERSION | cut -f1 -d'-')/$TARBALL
)

MD5SUMS=(
4575f9dea768437e17b160445c505f1a
)

build(){
  check_my_arch(){
    case $($CC -dumpmachine | cut -f1 -d'-') in
      i?86)
        return 0
      ;;
    esac
    echo "I can only be installed on x86!"
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
  cd usr/src/nv || return 1
  for f in Makefile.kbuild Makefile.nvidia; do
    sed -i 's%modprobe%true%g;s%sh makedevices.sh%@true%g' $f || return 1
    sed -i 's%depmod%true%g;s%-o root -g root%%g' $f || return 1
  done
  sed -i 's%rmmod_sanity_check)%foo1)%' conftest.sh || return 1
  sed -i 's%suser_sanity_check)%foo2)%' conftest.sh || return 1
  
  make MODULE_ROOT=$TMPROOT/lib/modules/$(uname -r)/kernel/drivers install || return 1
  gzip -v9 $TMPROOT/lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko || return 1
  mv $TMPROOT/lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko.gz \
    $TMPROOT/lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko || return 1
  
  MAJOR=$(echo $VERSION | cut -f1 -d'.')
  MINOR=$(echo $VERSION | cut -f2 -d'.' | cut -f1 -d'-')
  PATCH=$(echo $VERSION | cut -f3 -d'.' | cut -f1 -d'-')
  REV=${MAJOR}.${MINOR}
  DOCDIR="/usr/share/doc/NVIDIA_GLX"
  
  cd $SRCDIR/$DIR
  mkdir -pv $TMPROOT/usr/{bin,${LIBSDIR}/X11/modules/{drivers,extensions},share/{applications,man/man1}}
  
  install -vm 0755 usr/lib/libGL.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  ln -vsf libGL.so.${REV} $TMPROOT/usr/$LIBSDIR/libGL.so || return 1
  
  install -vm 0755 usr/lib/libGLcore.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  
  install -vm 0755 usr/X11R6/lib/modules/drivers/nvidia_drv.so \
    $TMPROOT/usr/$LIBSDIR/X11/modules/drivers || return 1

  install -vm 0755 usr/X11R6/lib/modules/extensions/libglx.so.${REV} \
    $TMPROOT/usr/$LIBSDIR/X11/modules/extensions || return 1
  ln -vsf libglx.so.${REV} \
    $TMPROOT/usr/$LIBSDIR/X11/modules/extensions/libglx.so || return 1

  install -vm 0755 usr/lib/libnvidia-tls.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  
  usr/bin/tls_test usr/bin/tls_test_dso.so 2>/dev/null && {
    mkdir -pv $TMPROOT/usr/$LIBSDIR/tls
    install -vm 0755 usr/lib/tls/libnvidia-tls.so.${REV} \
      $TMPROOT/usr/$LIBSDIR/tls || return 1
  }
  
  install -vm 0755 usr/lib/libnvidia-cfg.so.${REV} $TMPROOT/usr/$LIBSDIR || return 1
  
  install -vm 0755 usr/X11R6/lib/libXvMCNVIDIA.so.${REV} \
    $TMPROOT/usr/$LIBSDIR || return 1
  
  mkdir -pv $TMPROOT/usr/share/{doc/NVIDIA_GLX,pixmaps} || return 1
  
  cp -rv usr/share/doc/* $TMPROOT/$DOCDIR || return 1
  
  cp -va usr/share/pixmaps/* $TMPROOT/usr/share/pixmaps/ || return 1
  
  for x in nvidia-settings nvidia-xconfig; do
    install -vm 0755 usr/bin/$x $TMPROOT/usr/bin || exit 1
    zcat usr/share/man/man1/${x}.1.gz > \
      $TMPROOT/usr/share/man/man1/${x}.1 || exit 1
  done

  sed -e "s%__UTILS_PATH__%/usr/bin%" -e "s%__DOCS_PATH__%${DOCDIR}%" \
    -e "s%__PIXMAP_PATH__%/usr/share/pixmaps%" \
    usr/share/applications/nvidia-settings.desktop > \
    $TMPROOT/usr/share/applications/nvidia-settings.desktop || exit 1
  
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

pre_install(){
  rm -f /usr/$LIBSDIR/libGL.*
}

pre_upgrade(){
  pre_install
}

post_install(){
  update-desktop-database -q || return 1
  depmod || return 1
}

post_upgrade(){
  post_install || return 1
}
