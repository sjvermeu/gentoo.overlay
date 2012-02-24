# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gorg/selinux-gorg-2.20110726-r1.ebuild,v 1.2 2012/01/29 11:23:08 swift Exp $
EAPI="4"

IUSE=""
MODS="gorg"
BASEPOL="2.20110726-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for gorg"
KEYWORDS="amd64 x86"
