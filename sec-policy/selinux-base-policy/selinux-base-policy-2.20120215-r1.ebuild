# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dcc/selinux-dcc-2.20110726.ebuild,v 1.2 2011/10/23 12:42:45 swift Exp $
EAPI="4"

IUSE=""
MODS="application authlogin bootloader clock consoletype cron dmesg fstools getty hostname hotplug init iptables libraries locallogin logging lvm miscfiles modutils mount mta netutils nscd portage raid rsync selinuxutil ssh staff storage su sysadm sysnetwork udev userdomain usermanage unprivuser xdg"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DEPEND=">=sec-policy/selinux-base-2.20120215-r1"
RDEPEND="${DEPEND}"

DESCRIPTION="SELinux policy for core modules"

KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	# Override the command from the eclass, we need to load in base as well here
	local COMMAND
	for i in ${MODS}; do
		COMMAND="-i ${i}.pp ${COMMAND}"
	done

	for i in ${POLICY_TYPES}; do
		einfo "Inserting the following modules, with base, into the $i module store: ${MODS}"

		cd /usr/share/selinux/${i} || die "Could not enter /usr/share/selinux/${i}"
		semodule -s ${i} -b base.pp ${COMMAND} || die "Failed to load in base and modules ${MODS} in the $i policy store"
	done
}
