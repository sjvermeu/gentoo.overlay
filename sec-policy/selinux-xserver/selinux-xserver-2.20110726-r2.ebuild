# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-xserver/selinux-xserver-2.20110726-r1.ebuild,v 1.1 2011/12/17 10:39:17 swift Exp $
EAPI="4"

IUSE=""
MODS="xserver"
BASEPOL="2.20110726-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for xserver"

KEYWORDS="~amd64 ~x86"
