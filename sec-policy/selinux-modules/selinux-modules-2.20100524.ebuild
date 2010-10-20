# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-2.20091215.ebuild,v 1.1 2009/12/16 02:53:36 pebenito Exp $

EAPI="1"
IUSE="+peer_perms open_perms"

inherit eutils

DESCRIPTION="Gentoo policy modules for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="http://oss.tresys.com/files/refpolicy/refpolicy-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-apps/policycoreutils-1.30.30"
DEPEND="${RDEPEND}
	sys-devel/m4
	>=sys-apps/checkpolicy-1.30.12"

S=${WORKDIR}/

src_unpack() {
	local modfiles

	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	unpack ${A}

	for i in ${SELINUX_MODULES}; do
		modfiles="`find ${S}/refpolicy/policy/modules -iname $i.te` $modfiles"
		modfiles="`find ${S}/refpolicy/policy/modules -iname $i.fc` $modfiles"
	done

	for i in ${POLICY_TYPES}; do
		mkdir "${S}"/../${i}
		cp "${S}"/refpolicy/doc/Makefile.example "${S}"/../${i}/Makefile

		cp ${modfiles} "${S}"/../${i}

		if [ -n "${POLICY_PATCH}" ]; then
			cd "${S}"/../${i}
			epatch "${POLICY_PATCH}" |& die "failed patch ${i}"
		fi
	done
}

src_compile() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		make NAME=$i -C "${S}"/../${i} || die "${i} compile failed"
	done
}

src_install() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"
	local BASEDIR="/usr/share/selinux"

	for i in ${POLICY_TYPES}; do
		for j in ${SELINUX_MODULES}; do
			echo "Installing ${i} ${j} policy package"
			insinto ${BASEDIR}/${i}
			doins "${S}"/../${i}/${j}.pp
		done
	done
}

pkg_postinst() {
	local COMMAND
	for i in ${SELINUX_MODULES}; do
		COMMAND="-i ${i}.pp ${COMMAND}"
	done
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	if has "loadpolicy" $FEATURES ; then
		for i in ${POLICY_TYPES}; do
			einfo "Inserting the following modules into ${i} module store: ${SELINUX_MODULES}"

			cd "/usr/share/selinux/${i}"
			semodule -s "${i}" ${COMMAND} || die "Failed to install SELinux modules ${SELINUX_MODULES}"
		done
	else
		echo
		echo
		eerror "Policy has not been loaded.  It is strongly suggested"
		eerror "that the policy be loaded before continuing!!"
		echo
		einfo "Automatic policy loading can be enabled by adding"
		einfo "\"loadpolicy\" to the FEATURES in make.conf."
		echo
		echo
		ebeep 4
		epause 4
	fi
}
