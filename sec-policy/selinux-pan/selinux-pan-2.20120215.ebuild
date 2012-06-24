# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pan/selinux-pan-2.20120215.ebuild,v 1.3 2012/06/01 17:01:01 swift Exp $
EAPI="4"

IUSE=""
MODS="pan"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for pan"
KEYWORDS="amd64 x86"
DEPEND=">=sec-policy/selinux-xserver-2.20120215"
RDEPEND="${DEPEND}"
