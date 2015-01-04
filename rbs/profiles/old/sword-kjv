#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0"

TARBALL="KJV.zip"

DEPENDS=(
  sword
)

SRC1=(
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/$TARBALL
)

MD5SUMS=(
6c69ea68c330525466862a3026fb5375
)

build(){
  mkdir -p $TMPROOT/usr/share/sword || return 1
  cd $TMPROOT/usr/share/sword || return 1
  unzip -qqo $DOWNLOADDIR/KJV.zip || return 1
  cd $SRCDIR || return 1
}
