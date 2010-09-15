# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-2.20091215.ebuild,v 1.1 2009/12/16 02:53:36 pebenito Exp $

EAPI="3"
IUSE="+peer_perms open_perms"

inherit eutils git

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"

EGIT_REPO_URI="http://oss.tresys.com/git/refpolicy.git"
EGIT_PROJET="refpolicy"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-apps/policycoreutils-1.30.30"
DEPEND="${RDEPEND}
	sys-devel/m4
	>=sys-apps/checkpolicy-1.30.12"

S=${WORKDIR}/refpolicy

src_unpack() {
	git_src_unpack
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"
	MOD_CONF_VER="20090730"

#	cd "${S}/refpolicy"
#	epatch ${FILESDIR}/${PN}-${PV}.diff

	if ! use peer_perms; then
		sed -i -e '/network_peer_controls/d' \
			"${S}/policy/policy_capabilities"
	fi

	if ! use open_perms; then
		sed -i -e '/open_perms/d' \
			"${S}/policy/policy_capabilities"
	fi

	for i in ${POLICY_TYPES}; do
		cp -a "${S}" "${S}/../${i}"

		cp "${FILESDIR}/modules.conf.${i}.${MOD_CONF_VER}" \
			"${S}/../${i}/policy/modules.conf" \
			|| die "failed to set up modules.conf"
		sed -i -e '/^QUIET/s/n/y/' -e '/^MONOLITHIC/s/y/n/' \
			-e "/^NAME/s/refpolicy/$i/" "${S}/../${i}/build.conf" \
			|| die "build.conf setup failed."

		echo "DISTRO = gentoo" >> "${S}/../${i}/build.conf"

		if [ "${i}" == "targeted" ]; then
			sed -i -e '/root/d' -e 's/user_u/unconfined_u/' \
			"${S}/../${i}/config/appconfig-standard/seusers" \
			|| die "targeted seusers setup failed."
		fi
	done

	
}

src_compile() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		cd "${S}/../${i}"

		make base || die "${i} compile failed"
	done
}

src_install() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		cd "${S}/../${i}"

		make DESTDIR="${D}" install \
			|| die "${i} install failed."

		make DESTDIR="${D}" install-headers \
			|| die "${i} headers install failed."

		echo "run_init_t" > "${D}/etc/selinux/${i}/contexts/run_init_type"

		echo "textrel_shlib_t" >> "${D}/etc/selinux/${i}/contexts/customizable_types"

		# libsemanage won't make this on its own
		keepdir "/etc/selinux/${i}/policy"
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins "${FILESDIR}/config"
}

pkg_postinst() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	if has "loadpolicy" $FEATURES ; then
		for i in ${POLICY_TYPES}; do
			einfo "Inserting base module into ${i} module store."

			cd "/usr/share/selinux/${i}"
			semodule -s "${i}" -b base.pp
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
