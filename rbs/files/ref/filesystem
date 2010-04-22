#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1"

build(){
  install -d $TMPROOT/{bin,boot,dev,etc,home,${LIBSDIR},mnt,proc,sbin,sys,var} || return 1
  install -d $TMPROOT/root -m 0750 || return 1
  install -d $TMPROOT/tmp $TMPROOT/var/tmp -m 1777 || return 1
  install -d $TMPROOT/media/{floppy,cdrom} || return 1
  install -d $TMPROOT/usr/{bin,include,${LIBSDIR},sbin,share,src} || return 1
  install -d $TMPROOT/usr/share/{doc,info,locale,man} || return 1
  install -d $TMPROOT/usr/share/{misc,terminfo,zoneinfo} || return 1
  install -d $TMPROOT/usr/share/man/man{1,2,3,4,5,6,7,8} || return 1
  install -d $TMPROOT/var/{lock,log,mail,run,spool} || return 1
  install -d $TMPROOT/var/{cache,lib/{misc,locate},local} || return 1
  
  return 0
}
