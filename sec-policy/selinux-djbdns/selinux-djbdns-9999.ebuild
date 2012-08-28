# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="djbdns"
BASEPOL="9999"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-daemontools
"
RDEPEND="${DEPEND}"
