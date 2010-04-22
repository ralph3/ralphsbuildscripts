#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.1.4.2"

DIR="shadow-${VERSION}"
TARBALL="shadow-${VERSION}.tar.bz2"

DEPENDS=(
  linux-pam
)

SRC1=(
ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/${TARBALL}
)

MD5SUMS=(
d593a9cab93c48ee0a6ba056db8c1997
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --sysconfdir=/etc \
    --libdir=/$LIBSDIR --enable-shared --without-audit --without-selinux \
    --cache-file=config.cache || return 1
  sed -i 's/groups$(EXEEXT) //' src/Makefile || return 1
  sed -i -e '/groups1.xml/d' -e 's/groups.1//' man/Makefile || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/bin
  cp etc/{limits,login.access} $TMPROOT/etc || return 1
  mv $TMPROOT/usr/bin/passwd $TMPROOT/bin || return 1
  rm $TMPROOT/etc/pam.d/* || return 1
  rm -rf $TMPROOT/etc/default
  for file in $TMPROOT/etc/{limits,login.access}; do
    mv $file ${file}.tmpnew || return 1
  done

cat << "EOF" > $TMPROOT/etc/login.defs
#
# Delay in seconds before being allowed another attempt after a login failure
#
FAIL_DELAY		3

#
# Enable display of unknown usernames when login failures are recorded.
#
LOG_UNKFAIL_ENAB	no

#
# Enable logging of successful logins
#
LOG_OK_LOGINS		no

#
# Enable "syslog" logging of su activity - in addition to sulog file logging.
# SYSLOG_SG_ENAB does the same for newgrp and sg.
#
SYSLOG_SU_ENAB		yes
SYSLOG_SG_ENAB		yes

#
# If defined, either full pathname of a file containing device names or
# a ":" delimited list of device names.  Root logins will be allowed only
# upon these devices.
#
CONSOLE		/etc/securetty
#CONSOLE	console:tty01:tty02:tty03:tty04

#
# If defined, all su activity is logged to this file.
#
#SULOG_FILE	/var/log/sulog

#
# If defined, this file will be output before each login prompt.
#
#ISSUE_FILE	/etc/issue

#
# If defined, file which maps tty line to TERM environment parameter.
# Each line of the file is in a format something like "vt100  tty01".
#
#TTYTYPE_FILE	/etc/ttytype

#
# If defined, the command name to display when running "su -".  For
# example, if this is defined as "su" then a "ps" will display the
# command is "-su".  If not defined, then "ps" would display the
# name of the shell actually being run, e.g. something like "-sh".
#
SU_NAME		su

#
# *REQUIRED*
#   Directory where mailboxes reside, _or_ name of file, relative to the
#   home directory.  If you _do_ define both, MAIL_DIR takes precedence.
#
MAIL_DIR	/var/mail
#MAIL_FILE	.mail

#
# If defined, file which inhibits all the usual chatter during the login
# sequence.  If a full pathname, then hushed mode will be enabled if the
# user's name or shell are found in the file.  If not a full pathname, then
# hushed mode will be enabled if the file exists in the user's home directory.
#
HUSHLOGIN_FILE	.hushlogin
#HUSHLOGIN_FILE	/etc/hushlogins

#
# If defined, either a TZ environment parameter spec or the
# fully-rooted pathname of a file containing such a spec.
#
#ENV_TZ		TZ=CST6CDT
#ENV_TZ		/etc/tzname

#
# *REQUIRED*  The default PATH settings, for superuser and normal users.
#
# (they are minimal, add the rest in the shell startup files)
ENV_SUPATH	PATH=/sbin:/bin:/usr/sbin:/usr/bin
ENV_PATH	PATH=/bin:/usr/bin

#
# Terminal permissions
#
#	TTYGROUP	Login tty will be assigned this group ownership.
#	TTYPERM		Login tty will be set to this permission.
#
# If you have a "write" program which is "setgid" to a special group
# which owns the terminals, define TTYGROUP to the group number and
# TTYPERM to 0620.  Otherwise leave TTYGROUP commented out and assign
# TTYPERM to either 622 or 600.
#
TTYGROUP	tty
TTYPERM		0600

#
# Login configuration initializations:
#
#	ERASECHAR	Terminal ERASE character ('\010' = backspace).
#	KILLCHAR	Terminal KILL character ('\025' = CTRL/U).
#	UMASK		Default "umask" value.
#	ULIMIT		Default "ulimit" value.
#
# The ERASECHAR and KILLCHAR are used only on System V machines.
# The ULIMIT is used only if the system supports it.
# (now it works with setrlimit too; ulimit is in 512-byte units)
#
# Prefix these values with "0" to get octal, "0x" to get hexadecimal.
#
ERASECHAR	0177
KILLCHAR	025
UMASK		022
#ULIMIT		2097152

#
# Password aging controls:
#
#	PASS_MAX_DAYS	Maximum number of days a password may be used.
#	PASS_MIN_DAYS	Minimum number of days allowed between password changes.
#	PASS_MIN_LEN	Minimum acceptable password length.
#	PASS_WARN_AGE	Number of days warning given before a password expires.
#
PASS_MAX_DAYS	99999
PASS_MIN_DAYS	0
PASS_WARN_AGE	7

#
# Min/max values for automatic uid selection in useradd
#
UID_MIN			 1000
UID_MAX			60000

#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN			  100
GID_MAX			60000

#
# Max number of login retries if password is bad
#
LOGIN_RETRIES		5

#
# Max time in seconds for login
#
LOGIN_TIMEOUT		60

#
# Number of significant characters in the password for crypt().
# Default is 8, don't change unless your crypt() is better.
# Ignored if MD5_CRYPT_ENAB set to "yes".
#
#PASS_MAX_LEN		8

#
# Which fields may be changed by regular users using chfn - use
# any combination of letters "frwh" (full name, room number, work
# phone, home phone).  If not defined, no changes are allowed.
# For backward compatibility, "yes" = "rwh" and "no" = "frwh".
# 
CHFN_RESTRICT		rwh

#
# Password prompt (%s will be replaced by user name).
#
# XXX - it doesn't work correctly yet, for now leave it commented out
# to use the default which is just "Password: ".
#LOGIN_STRING		"%s's Password: "

#
# List of groups to add to the user's supplementary group set
# when logging in on the console (as determined by the CONSOLE
# setting).  Default is none.
#
# Use with caution - it is possible for users to gain permanent
# access to these groups, even when not logged in on the console.
# How to do it is left as an exercise for the reader...
#
#CONSOLE_GROUPS		floppy:audio:cdrom

#
# Should login be allowed if we can't cd to the home directory?
# Default in no.
#
DEFAULT_HOME	yes

#
# If defined, this command is run when removing a user.
# It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument).
#
#USERDEL_CMD	/usr/sbin/userdel_local

#
# Enable setting of the umask group bits to be the same as owner bits
# (examples: 022 -> 002, 077 -> 007) for non-root users, if the uid is
# the same as gid, and username is the same as the primary group name.
#
# This also enables userdel to remove user groups if no members exist.
#
USERGROUPS_ENAB yes
EOF

cat << EOF > $TMPROOT/etc/issue.tmpnew


    Linux \r \m -- Built with Ralph's Build System


EOF

cat << "EOF" > $TMPROOT/etc/pam.d/chage.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	        required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/chfn.tmpnew || return 1
auth		sufficient	pam_rootok.so
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/chsh.tmpnew || return 1
auth            required   pam_shells.so
auth		sufficient	pam_rootok.so
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/groupadd.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	        required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/groupmod.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/login.tmpnew || return 1
auth       required   pam_issue.so issue=/etc/issue
auth       requisite  pam_nologin.so
auth            required        pam_unix.so     nullok
auth       optional   pam_group.so
session    required   pam_limits.so
session    optional   pam_lastlog.so
session    optional   pam_motd.so
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/newusers.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	        required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/passwd.tmpnew || return 1
password        required        pam_unix.so     nullok
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/su.tmpnew || return 1
auth       sufficient pam_rootok.so
session    optional   pam_mail.so nopen
session    required   pam_limits.so
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/useradd.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/userdel.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	required	pam_permit.so
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/usermod.tmpnew || return 1
auth		sufficient	pam_rootok.so
account	required	pam_permit.so
EOF
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/'
  VERSION_STRING='shadow-%version%.tar.bz2'
  MIRRORS=(
    'ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/shadow-%version%.tar.bz2'
  )
}
