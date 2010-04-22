#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.0"

#############################
DEPENDS=(
  zenity
)

build(){
  mkdir -p $TMPROOT/usr/bin || return 1
cat << "EOF" > $TMPROOT/usr/bin/yelp || return 1
#!/bin/bash

zenity --info --no-wrap --text "The program \"$(basename $0)\" has been disabled due to dependency issues regarding xulrunner."

exit 0
EOF
  chmod 755 $TMPROOT/usr/bin/yelp || return 1
  ln -sfn yelp $TMPROOT/usr/bin/gnome-help || return 1
}
#############################




















cat << "COMMENT" >/dev/null

VERSION="2.24.0"

DIR="yelp-${VERSION}"
TARBALL="yelp-${VERSION}.tar.bz2"

DEPENDS=(
  rarian
  xulrunner
)

SRC1=(
  $(gnome_mirrors yelp)
)

MD5SUMS=(
15eb2f538d970600c1e0a461f7d88b55
)

build(){
  local INCLUDES
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" \
    ./configure --prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --with-gecko=libxul || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script yelp install || return 1
}

pre_remove(){
  gnome_script yelp remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/yelp/%minor_version%/'
  VERSION_STRING='yelp-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/yelp/%minor_version%/yelp-%version%.tar.bz2'
  )
}

COMMENT

