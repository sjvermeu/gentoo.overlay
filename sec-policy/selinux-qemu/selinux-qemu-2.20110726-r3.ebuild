# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qemu/selinux-qemu-2.20110726-r3.ebuild,v 1.1 2012/01/14 19:59:58 swift Exp $
EAPI="4"

IUSE=""
MODS="qemu"
BASEPOL="2.20110726-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for qemu"
KEYWORDS="~amd64 ~x86"
RDEPEND="sec-policy/selinux-virt"
