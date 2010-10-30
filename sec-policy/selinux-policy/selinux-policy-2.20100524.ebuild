# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openfoam-meta/openfoam-meta-1.5.ebuild,v 1.1 2009/04/25 16:28:29 patrick Exp $

DESCRIPTION="Meta package depending on all policies required for a Gentoo-based
SELinux system to function properly"
HOMEPAGE="http://oss.tresys.com/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="~sec-policy/selinux-application-${PV}
         ~sec-policy/selinux-authlogin-${PV}
		 ~sec-policy/selinux-bootloader-${PV}
		 ~sec-policy/selinux-clock-${PV}
		 ~sec-policy/selinux-consoletype-${PV}
		 ~sec-policy/selinux-cron-${PV}
		 ~sec-policy/selinux-dmesg-${PV}
		 ~sec-policy/selinux-fstools-${PV}
		 ~sec-policy/selinux-getty-${PV}
		 ~sec-policy/selinux-hostname-${PV}
		 ~sec-policy/selinux-hotplug-${PV}
		 ~sec-policy/selinux-init-${PV}
		 ~sec-policy/selinux-iptables-${PV}
		 ~sec-policy/selinux-locallogin-${PV}
		 ~sec-policy/selinux-lvm-${PV}
		 ~sec-policy/selinux-miscfiles-${PV}
		 ~sec-policy/selinux-modutils-${PV}
		 ~sec-policy/selinux-mount-${PV}
		 ~sec-policy/selinux-mta-${PV}
		 ~sec-policy/selinux-netutils-${PV}
		 ~sec-policy/selinux-nscd-${PV}
		 ~sec-policy/selinux-portage-${PV}
		 ~sec-policy/selinux-raid-${PV}
		 ~sec-policy/selinux-rsync-${PV}
		 ~sec-policy/selinux-selinuxutil-${PV}
		 ~sec-policy/selinux-ssh-${PV}
		 ~sec-policy/selinux-staff-${PV}
		 ~sec-policy/selinux-storage-${PV}
		 ~sec-policy/selinux-su-${PV}
		 ~sec-policy/selinux-sysadm-${PV}
		 ~sec-policy/selinux-sysnetwork-${PV}
		 ~sec-policy/selinux-udev-${PV}
		 ~sec-policy/selinux-userdomain-${PV}
		 ~sec-policy/selinux-usermanage-${PV}
		 ~sec-policy/selinux-unprivuser-${PV}
		 " 
DEPEND="${RDEPEND}"
