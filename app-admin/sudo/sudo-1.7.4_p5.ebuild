# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.7.4_p5.ebuild,v 1.8 2011/08/11 10:58:35 ulm Exp $

inherit eutils pam

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
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="pam skey offensive ldap selinux"

DEPEND="pam? ( virtual/pam )
	ldap? (
		>=net-nds/openldap-2.1.30-r1
		dev-libs/cyrus-sasl
	)
	!pam? ( skey? ( >=sys-auth/skey-1.1.5-r1 ) )
	app-misc/editor-wrapper
	virtual/editor
	virtual/mta"
RDEPEND="selinux? ( sec-policy/selinux-sudo )
	ldap? ( dev-lang/perl )
	pam? ( sys-auth/pambase )
	${DEPEND}"
DEPEND="${DEPEND}
	sys-devel/bison"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use pam && use skey; then
		ewarn "You cannot enable both S/KEY and PAM at the same time, PAM will"
		ewarn "be used then."
	fi
}

src_unpack() {
	unpack ${A}; cd "${S}"

	# compatability fix.
	epatch "${FILESDIR}"/${PN}-skeychallengeargs.diff

	# additional variables to disallow, should user disable env_reset.

	# NOTE: this is not a supported mode of operation, these variables
	#       are added to the blacklist as a convenience to administrators
	#       who fail to heed the warnings of allowing untrusted users
	#       to access sudo.
	#
	#       there is *no possible way* to foresee all attack vectors in
	#       all possible applications that could potentially be used via
	#       sudo, these settings will just delay the inevitable.
	#
	#       that said, I will accept suggestions for variables that can
	#       be misused in _common_ interpreters or libraries, such as
	#       perl, bash, python, ruby, etc., in the hope of dissuading
	#       a casual attacker.

	# XXX: perl should be using suid_perl.
	# XXX: users can remove/add more via env_delete and env_check.
	# XXX: <?> = probably safe enough for most circumstances.

	einfo "Blacklisting common variables (env_delete)..."
		sudo_bad_var() {
			local target='env.c' marker='\*initial_badenv_table\[\]'

			ebegin "	$1"
			sed -i 's#\(^.*'${marker}'.*$\)#\1\n\t"'${1}'",#' "${S}"/${target}
			eend $?
		}

		sudo_bad_var 'PERLIO_DEBUG'   # perl, write debug to file.
		sudo_bad_var 'FPATH'          # ksh, search path for functions.
		sudo_bad_var 'NULLCMD'        # zsh, command on null-redir. <?>
		sudo_bad_var 'READNULLCMD'    # zsh, command on null-redir. <?>
		sudo_bad_var 'GLOBIGNORE'     # bash, glob paterns to ignore. <?>
		sudo_bad_var 'PYTHONHOME'     # python, module search path.
		sudo_bad_var 'PYTHONPATH'     # python, search path.
		sudo_bad_var 'PYTHONINSPECT'  # python, allow inspection.
		sudo_bad_var 'RUBYLIB'        # ruby, lib load path.
		sudo_bad_var 'RUBYOPT'        # ruby, cl options.
		sudo_bad_var 'ZDOTDIR'        # zsh, path to search for dotfiles.
	einfo "...done."

	# prevent binaries from being stripped.
	sed -i 's/\($(INSTALL).*\) -s \(.*[(sudo|visudo)]\)/\1 \2/g' Makefile.in
}

src_compile() {
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

	einfo "...done."

	if use pam; then
		myconf="--with-pam --without-skey"
	elif use skey; then
		myconf="--without-pam --with-skey"
	else
		myconf="--without-pam --without-skey"
	fi

	# audit: somebody got to explain me how I can test this before I
	# enable it.. — Diego
	econf --with-secure-path="${ROOTPATH}" \
		--with-editor=/usr/libexec/gentoo-editor \
		--with-env-editor \
		$(use_with offensive insults) \
		$(use_with offensive all-insults) \
		$(use_with ldap ldap_conf_file /etc/ldap.conf.sudo) \
		$(use_with ldap) \
		--without-linux-audit \
		--with-timedir=/var/db/sudo \
		--docdir=/usr/share/doc/${PF} \
		${myconf}

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use ldap; then
		dodoc README.LDAP schema.OpenLDAP
		dosbin sudoers2ldif

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

	insinto /etc
	doins "${S}"/sudoers
	fperms 0440 /etc/sudoers

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
