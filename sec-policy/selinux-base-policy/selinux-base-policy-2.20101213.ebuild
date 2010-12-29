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

S=${WORKDIR}/

src_unpack() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	unpack ${A}
	epatch ${FILESDIR}/fix-udev.patch
	epatch ${FILESDIR}/fix-sysadm.patch
	epatch ${FILESDIR}/fix-networkmanager.patch
	epatch ${FILESDIR}/fix-raid.patch

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

		echo "application = base" > "${S}/${i}/policy/modules.conf"
		echo "authlogin = base" >> "${S}/${i}/policy/modules.conf"
		echo "bootloader = base" >> "${S}/${i}/policy/modules.conf"
		echo "clock = base" >> "${S}/${i}/policy/modules.conf"
		echo "consoletype = base" >> "${S}/${i}/policy/modules.conf"
		echo "corecommands = base" >> "${S}/${i}/policy/modules.conf"
		echo "corenetwork = base" >> "${S}/${i}/policy/modules.conf"
		echo "cron = base" >> "${S}/${i}/policy/modules.conf"
		echo "devices = base" >> "${S}/${i}/policy/modules.conf"
		echo "dmesg = base" >> "${S}/${i}/policy/modules.conf"
		echo "domain = base" >> "${S}/${i}/policy/modules.conf"
		echo "files = base" >> "${S}/${i}/policy/modules.conf"
		echo "filesystem = base" >> "${S}/${i}/policy/modules.conf"
		echo "fstools = base" >> "${S}/${i}/policy/modules.conf"
		echo "getty = base" >> "${S}/${i}/policy/modules.conf"
		echo "hostname = base" >> "${S}/${i}/policy/modules.conf"
		echo "hotplug = base" >> "${S}/${i}/policy/modules.conf"
		echo "init = base" >> "${S}/${i}/policy/modules.conf"
		echo "iptables = base" >> "${S}/${i}/policy/modules.conf"
		echo "kernel = base" >> "${S}/${i}/policy/modules.conf"
		echo "libraries = base" >> "${S}/${i}/policy/modules.conf"
		echo "locallogin = base" >> "${S}/${i}/policy/modules.conf"
		echo "logging = base" >> "${S}/${i}/policy/modules.conf"
		echo "lvm = base" >> "${S}/${i}/policy/modules.conf"
		echo "miscfiles = base" >> "${S}/${i}/policy/modules.conf"
		echo "mcs = base" >> "${S}/${i}/policy/modules.conf"
		echo "mls = base" >> "${S}/${i}/policy/modules.conf"
		echo "modutils = base" >> "${S}/${i}/policy/modules.conf"
		echo "mount = base" >> "${S}/${i}/policy/modules.conf"
		echo "mta = base" >> "${S}/${i}/policy/modules.conf"
		echo "netutils = base" >> "${S}/${i}/policy/modules.conf"
		echo "nscd = base" >> "${S}/${i}/policy/modules.conf"
		echo "raid = base" >> "${S}/${i}/policy/modules.conf"
		echo "rsync = base" >> "${S}/${i}/policy/modules.conf"
		echo "selinux = base" >> "${S}/${i}/policy/modules.conf"
		echo "selinuxutil = base" >> "${S}/${i}/policy/modules.conf"
		echo "ssh = base" >> "${S}/${i}/policy/modules.conf"
		echo "staff = base" >> "${S}/${i}/policy/modules.conf"
		echo "storage = base" >> "${S}/${i}/policy/modules.conf"
		echo "su = base" >> "${S}/${i}/policy/modules.conf"
		echo "sysadm = base" >> "${S}/${i}/policy/modules.conf"
		echo "sysnetwork = base" >> "${S}/${i}/policy/modules.conf"
		echo "terminal = base" >> "${S}/${i}/policy/modules.conf"
		echo "ubac = base" >> "${S}/${i}/policy/modules.conf"
		echo "udev = base" >> "${S}/${i}/policy/modules.conf"
		echo "userdomain = base" >> "${S}/${i}/policy/modules.conf"
		echo "usermanage = base" >> "${S}/${i}/policy/modules.conf"
		echo "unprivuser = base" >> "${S}/${i}/policy/modules.conf"

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

}

src_compile() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		cd "${S}/${i}"

		make base || die "${i} compile failed"
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
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins "${FILESDIR}/config"
}

pkg_postinst() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	for i in ${POLICY_TYPES}; do
		einfo "Inserting base module into ${i} module store."

		cd "/usr/share/selinux/${i}"
		semodule -s "${i}" -b base.pp
	done
}
