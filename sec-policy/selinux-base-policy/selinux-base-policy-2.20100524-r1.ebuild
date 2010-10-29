# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-2.20091215.ebuild,v 1.1 2009/12/16 02:53:36 pebenito Exp $

EAPI="1"
IUSE="+peer_perms open_perms"

inherit eutils

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="http://oss.tresys.com/files/refpolicy/refpolicy-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-apps/policycoreutils-1.30.30"
DEPEND="${RDEPEND}
	sys-devel/m4
	>=sys-apps/checkpolicy-1.30.12"

BASEMODS="application authlogin bootloader clock consoletype \
		corecommands corenetwork cron devices dmesg domain files filesystem \
		fstools getty hostname hotplug init iptables kernel libraries \
		locallogin logging lvm miscfiles mcs mls modutils mount mta netutils \
		nscd portage raid rsync selinux selinuxutil ssh staff storage su \
		sysadm sysnetwork terminal ubac udev userdomain usermanage unprivuser"
	
S=${WORKDIR}/

src_unpack() {
	local modules

	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	unpack ${A}

	if ! use peer_perms; then
		sed -i -e '/network_peer_controls/d' \
			"${S}/refpolicy/policy/policy_capabilities"
	fi

	if ! use open_perms; then
		sed -i -e '/open_perms/d' \
			"${S}/refpolicy/policy/policy_capabilities"
	fi

	for i in ${POLICY_TYPES}; do
		cp -a "${S}/refpolicy" "${S}/${i}"

		#cp "${FILESDIR}/modules.conf.${i}.${MOD_CONF_VER}" \
		#	"${S}/${i}/policy/modules.conf" \
		#	|| die "failed to set up modules.conf"
		sed -i -e '/^QUIET/s/n/y/' -e '/^MONOLITHIC/s/y/n/' \
			-e "/^NAME/s/refpolicy/$i/" "${S}/${i}/build.conf" \
			|| die "build.conf setup failed."

		echo "DISTRO = gentoo" >> "${S}/${i}/build.conf"

		if [ "${i}" == "targeted" ]; then
			sed -i -e '/root/d' -e 's/user_u/unconfined_u/' \
			"${S}/${i}/config/appconfig-standard/seusers" \
			|| die "targeted seusers setup failed."
		fi
	done

	for i in ${BASEMODS};
	do
		modfiles="`find ${S}/refpolicy/policy/modules -iname $i.te` $modfiles"
		modfiles="`find ${S}/refpolicy/policy/modules -iname $i.fc` $modfiles"
	done

	for i in ${POLICY_TYPES}; do
		mkdir "${S}"/../${i}
		cp "${S}"/refpolicy/doc/Makefile.example "${S}"/../${i}/Makefile

		cp ${modules} "${S}"/../${i}

		if [ -n "${POLICY_PATCH}" ]; then
			cd "${S}"/../${i}
			epatch "${POLICY_PATCH}" |& die "failed patch ${i}"
		fi
	done
}

src_compile() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		cd "${S}/${i}"

		make base || die "${i} compile failed"

		make NAME=$i -C "${S}"/../${i} || die "${i} compile failed"
	done
}

src_install() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		cd "${S}/${i}"

		make DESTDIR="${D}" install \
			|| die "${i} install failed."

		make DESTDIR="${D}" install-headers \
			|| die "${i} headers install failed."

		echo "run_init_t" > "${D}/etc/selinux/${i}/contexts/run_init_type"

		echo "textrel_shlib_t" >> "${D}/etc/selinux/${i}/contexts/customizable_types"

		# libsemanage won't make this on its own
		keepdir "/etc/selinux/${i}/policy"

		for j in ""; do
			echo "Installing ${i} ${j} policy package"
			insinto ${BASEDIR}/${i}
			doins "${S}"/../${i}/${j}.pp
		done
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins "${FILESDIR}/config"
}

pkg_postinst() {
	local COMMAND

	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${BASEMODS};
	do
		COMMAND="-i ${i}.pp ${COMMAND}"	
	done

	if has "loadpolicy" $FEATURES ; then
		for i in ${POLICY_TYPES}; do
			einfo "Inserting base module into ${i} module store."

			cd "/usr/share/selinux/${i}"
			semodule -s "${i}" -b base.pp

			einfo "Inserting the following base modules into ${i} module store: ${BASEMODS}"
			semodule -s "${i}" ${COMMAND} || die "Failed to install SELinux modules ${BASEMODS}"
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
