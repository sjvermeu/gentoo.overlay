# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-oident/selinux-oident-2.20110726.ebuild,v 1.2 2012/01/29 11:23:09 swift Exp $
EAPI="4"

IUSE=""
MODS="oident"
BASEPOL="2.20110726-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for oident"
KEYWORDS="amd64 x86"
RDEPEND="!<=sec-policy/selinux-oidentd-2.20110726
	>=sys-apps/policycoreutils-2.1.0"
