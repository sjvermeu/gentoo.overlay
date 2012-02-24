# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qemu/selinux-qemu-2.20110726-r2.ebuild,v 1.3 2012/01/29 11:23:10 swift Exp $
EAPI="4"

IUSE=""
MODS="qemu"
BASEPOL="2.20110726-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for qemu"
KEYWORDS="amd64 x86"
RDEPEND="sec-policy/selinux-virt"
