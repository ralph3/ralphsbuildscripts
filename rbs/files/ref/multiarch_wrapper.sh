#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0"

DIR="multiarch_wrapper-${VERSION}"

DEPENDS=(
  gcc
)

build(){
  if [ "$SYSTYPE" != "MULTILIB" ]; then
    echo "multiarch_wrapper is only for MULTILIB systems."
    return 1
  fi
  mkdir -p $SRCDIR/$DIR || return 1
  cd $SRCDIR/$DIR || return 1
cat > multiarch_wrapper.c << "EOF"
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

#ifndef USE_ARCH
#define USE_ARCH "64"
#endif

int main(int argc, char **argv)
{
  char *filename;
  char *use_arch;

  if(!(use_arch = getenv("USE_ARCH")))
    use_arch = USE_ARCH;

  filename = (char *) malloc(strlen(argv[0]) + strlen(use_arch) + 2);
  strcpy(filename, argv[0]);
  strcat(filename, "-");
  strcat(filename, use_arch);

  execvp(filename, argv);
  perror(argv[0]);
  free(filename);
}
EOF
  echo "$CC $BUILD $CFLAGS -o multiarch_wrapper multiarch_wrapper.c"
  $CC $BUILD $CFLAGS -o multiarch_wrapper multiarch_wrapper.c || return 1
  mkdir -vp $TMPROOT/usr/bin || return 1
  install -v -m 755 multiarch_wrapper $TMPROOT/usr/bin || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
