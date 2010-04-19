#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.903"

DIR="gxine-${VERSION}"
TARBALL="gxine-${VERSION}.tar.bz2"

DEPENDS=(
  xine-lib
)

SRC1=(
http://prdownloads.sourceforge.net/xine/${TARBALL}
)

MD5SUMS=(
3878ffb159fa5aca093617dab4924e6d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --sysconfdir=/etc --without-browser-plugin || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/etc/profile.d || return 1
cat << "EOF" > $TMPROOT/etc/profile.d/gxine.sh || return 1
#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/firefox
EOF
  chmod 755 $TMPROOT/etc/profile.d/gxine.sh || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/xine/'
  VERSION_STRING='gxine-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/xine/gxine-%version%.tar.bz2'
  )
}
