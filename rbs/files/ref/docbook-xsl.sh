#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.75.2"

DIR="docbook-xsl-${VERSION}"
TARBALL="docbook-xsl-${VERSION}.tar.bz2"

DEPENDS=(
  libxml2
)

SRC1=(
http://prdownloads.sourceforge.net/docbook/${TARBALL}
)

MD5SUMS=(
0c76a58a8e6cb5ab49f819e79917308f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  install -v -d \
    $TMPROOT/usr/share/xml/docbook/xsl-stylesheets-${VERSION} || \
    return 1
  for x in $(find * -type d -maxdepth 0) INSTALL VERSION; do
    cp -vaf $x \
    $TMPROOT/usr/share/xml/docbook/xsl-stylesheets-${VERSION} || return 1
  done
  #install -d $TMPROOT/usr/share/doc/xml || return 1
  #cp -af doc/* $TMPROOT/usr/share/doc/xml || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
if [ ! -f /etc/xml/catalog ]; then
	xmlcatalog --noout --create /etc/xml/catalog || return 1
fi

if [ ! -e /etc/xml/docbook ]; then
	xmlcatalog --noout --create /etc/xml/docbook || return 1
fi

xmlcatalog --noout --add "rewriteSystem" \
    "http://docbook.sourceforge.net/release/xsl/${VERSION}" \
    "/usr/share/xml/docbook/xsl-stylesheets-${VERSION}" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "rewriteURI" \
    "http://docbook.sourceforge.net/release/xsl/${VERSION}" \
    "/usr/share/xml/docbook/xsl-stylesheets-${VERSION}" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "rewriteSystem" \
    "http://docbook.sourceforge.net/release/xsl/current" \
    "/usr/share/xml/docbook/xsl-stylesheets-${VERSION}" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "rewriteURI" \
    "http://docbook.sourceforge.net/release/xsl/current" \
    "/usr/share/xml/docbook/xsl-stylesheets-${VERSION}" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "delegateSystem" \
    "http://docbook.sourceforge.net/release/xsl/" \
    "file:///etc/xml/docbook" /etc/xml/catalog || return 1
xmlcatalog --noout --add "delegateURI" \
    "http://docbook.sourceforge.net/release/xsl/" \
    "file:///etc/xml/docbook" /etc/xml/catalog || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=21935&package_id=16608'
  VERSION_STRING='docbook-xsl-%version%.tar.bz2'
  VERSION_FILTERS='pre'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/docbook/docbook-xsl-%version%.tar.bz2'
  )
}