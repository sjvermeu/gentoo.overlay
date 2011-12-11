# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.8.1_p2.ebuild,v 1.9 2011/09/03 16:08:05 armin76 Exp $

EAPI=4

inherit eutils pam multilib libtool

MY_P=${P/_/}
MY_P=${MY_P/beta/b}

case "${P}" in
	*_beta* | *_rc*)
		uri_prefix=beta/
		;;
	*)
		uri_prefix=""
		;;
esac

DESCRIPTION="Allows users or groups to run commands as other users"
HOMEPAGE="http://www.sudo.ws/"
SRC_URI="http://www.sudo.ws/sudo/dist/${uri_prefix}${MY_P}.tar.gz
	ftp://ftp.sudo.ws/pub/sudo/${uri_prefix}${MY_P}.tar.gz"

# Basic license is ISC-style as-is, some files are released under
# 3-clause BSD license
LICENSE="as-is BSD"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="pam offensive ldap selinux skey"

DEPEND="pam? ( virtual/pam )
	skey? ( >=sys-auth/skey-1.1.5-r1 )
	ldap? (
		>=net-nds/openldap-2.1.30-r1
		dev-libs/cyrus-sasl
	)
	>=app-misc/editor-wrapper-3
	virtual/editor
	virtual/mta"
RDEPEND="selinux? ( sec-policy/selinux-sudo )
	ldap? ( dev-lang/perl )
	pam? ( sys-auth/pambase )
	${DEPEND}"
DEPEND="${DEPEND}
	sys-devel/bison"

S=${WORKDIR}/${MY_P}

REQUIRED_USE="pam? ( !skey ) skey? ( !pam )"

MAKEOPTS="${MAKEOPTS} SAMPLES="

src_prepare() {
	elibtoolize
}

src_configure() {
	local line ROOTPATH

	# FIXME: secure_path is a compile time setting. using ROOTPATH
	# is not perfect, env-update may invalidate this, but until it
	# is available as a sudoers setting this will have to do.
	einfo "Setting secure_path..."

		# why not use grep? variable might be expanded from other variables
		# declared in that file. cannot just source the file, would override
		# any variables already set.
		eval `PS4= bash -x /etc/profile.env 2>&1 | \
			while read line; do
				case $line in
					ROOTPATH=*) echo $line; break;;
					*) continue;;
				esac
			done`  && einfo "	Found ROOTPATH..." || \
				ewarn "	Failed to find ROOTPATH, please report this."

		# remove duplicate path entries from $1
		cleanpath() {
			local i=1 x n IFS=:
			local -a paths;	paths=($1)

			for ((n=${#paths[*]}-1;i<=n;i++)); do
				for ((x=0;x<i;x++)); do
					test "${paths[i]}" == "${paths[x]}" && {
						einfo "	Duplicate entry ${paths[i]} removed..." 1>&2
						unset paths[i]; continue 2; }
				done; # einfo "	Adding ${paths[i]}..." 1>&2
			done; echo "${paths[*]}"
		}

		ROOTPATH=$(cleanpath /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin${ROOTPATH:+:${ROOTPATH}})

		# strip gcc path (bug #136027)
		rmpath() {
			declare e newpath oldpath=${!1} PATHvar=$1 thisp IFS=:
			shift
			for thisp in $oldpath; do
				for e; do [[ $thisp == $e ]] && continue 2; done
				newpath=$newpath:$thisp
			done
			eval $PATHvar='${newpath#:}'
		}

		rmpath ROOTPATH '*/gcc-bin/*'
		rmpath ROOTPATH '*/gnat-gcc-bin/*'
		rmpath ROOTPATH '*/gnat-gcc/*'

	einfo "...done."

	# audit: somebody got to explain me how I can test this before I
	# enable it.. — Diego
	econf --with-secure-path="${ROOTPATH}" \
		--with-editor=/usr/libexec/editor \
		--with-env-editor \
		$(use_with offensive insults) \
		$(use_with offensive all-insults) \
		$(use_with ldap ldap_conf_file /etc/ldap.conf.sudo) \
		$(use_with ldap) \
		$(use_with pam) \
		$(use_with skey) \
		--without-opie \
		--without-linux-audit \
		--with-timedir=/var/db/sudo \
		--with-plugindir=/usr/$(get_libdir)/sudo \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use ldap; then
		dodoc README.LDAP doc/schema.OpenLDAP
		dosbin plugins/sudoers/sudoers2ldif

		cat - > "${T}"/ldap.conf.sudo <<EOF
# See ldap.conf(5) and README.LDAP for details\n"
# This file should only be readable by root\n\n"
# supported directives: host, port, ssl, ldap_version\n"
# uri, binddn, bindpw, sudoers_base, sudoers_debug\n"
# tls_{checkpeer,cacertfile,cacertdir,randfile,ciphers,cert,key
EOF

		insinto /etc
		doins "${T}"/ldap.conf.sudo
		fperms 0440 /etc/ldap.conf.sudo
	fi

	pamd_mimic system-auth sudo auth account session

	keepdir /var/db/sudo
	fperms 0700 /var/db/sudo
}

pkg_postinst() {
	if use ldap; then
		ewarn
		ewarn "sudo uses the /etc/ldap.conf.sudo file for ldap configuration."
		ewarn
		if egrep -q '^[[:space:]]*sudoers:' "${ROOT}"/etc/nsswitch.conf; then
			ewarn "In 1.7 series, LDAP is no more consulted, unless explicitly"
			ewarn "configured in /etc/nsswitch.conf."
			ewarn
			ewarn "To make use of LDAP, add this line to your /etc/nsswitch.conf:"
			ewarn "  sudoers: ldap files"
			ewarn
		fi
	fi

	elog "To use the -A (askpass) option, you need to install a compatible"
	elog "password program from the following list. Starred packages will"
	elog "automatically register for the use with sudo (but will not force"
	elog "the -A option):"
	elog ""
	elog " [*] net-misc/ssh-askpass-fullscreen"
	elog "     net-misc/x11-ssh-askpass"
	elog ""
	elog "You can override the choice by setting the SUDO_ASKPASS environmnent"
	elog "variable to the program you want to use."
}
