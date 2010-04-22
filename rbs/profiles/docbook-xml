#!/bin/bash

DISABLE_MULTILIB=1

#wait before upgrade to 5.0
VERSION="4.5"

DIR="docbook-xml-${VERSION}"
TARBALL="docbook-xml-${VERSION}.zip"

DEPENDS=(
  libxml2
  unzip
)

SRC1=(
http://www.docbook.org/xml/${VERSION}/${TARBALL}
)

MD5SUMS=(
  03083e288e87a7e829e437358da7ef9e
)

build(){
  echo "Unpacking ${TARBALL}..."
  mkdir -p $SRCDIR/$DIR || return 1
  cd $SRCDIR/$DIR || return 1
  unzip -qqo $DOWNLOADDIR/$TARBALL || return 1
  install -v -d -m755 \
    $TMPROOT/usr/share/xml/docbook/xml-dtd-${VERSION} || return 1
  install -v -d -m755 $TMPROOT/etc/xml || return 1
  chown -R root:root . || return 1
  cp -v -af docbook.cat *.dtd ent/ *.mod \
    $TMPROOT/usr/share/xml/docbook/xml-dtd-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
[ ! -e "/etc/xml/docbook" ] && {
  xmlcatalog --noout --create /etc/xml/docbook || return 1
}
[ ! -e "/etc/xml/catalog" ] && {
  xmlcatalog --noout --create /etc/xml/catalog || return 1
}
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V${VERSION}//EN" \
    "http://www.oasis-open.org/docbook/xml/${VERSION}/docbookx.dtd" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/calstblx.dtd" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/soextblx.dtd" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbpoolx.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbhierx.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/htmltblx.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbnotnx.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbcentx.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V${VERSION}//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}/dbgenent.mod" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/${VERSION}" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/${VERSION}" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
    /etc/xml/docbook || return 1
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//ENTITIES DocBook XML" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//DTD DocBook XML" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog || return 1
xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog
for DTDVERSION in "4.1.2" "4.2" "4.3"; do
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
    /etc/xml/docbook || return 1
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
    /etc/xml/docbook || return 1
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file:///usr/share/xml/docbook/xml-dtd-${VERSION}" \
    /etc/xml/docbook || return 1
  xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog || return 1
  xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog || return 1
done
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://www.docbook.org/xml/%version%/'
  VERSION_STRING='docbook-xml-%version%.zip'
  MINOR_VERSION=4
  VERSION_FILTERS="[a-z] [A-Z]"
  MIRRORS=(
    'http://www.docbook.org/xml/%version%/docbook-xml-%version%.zip'
  )
}
