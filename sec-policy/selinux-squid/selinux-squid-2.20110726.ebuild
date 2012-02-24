# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-squid/selinux-squid-2.20110726.ebuild,v 1.2 2011/10/23 12:42:28 swift Exp $
EAPI="4"

IUSE=""
MODS="squid"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for squid"

KEYWORDS="amd64 x86"
DEPEND=">=sec-policy/selinux-apache-2.20110726-r1"
RDEPEND="${DEPEND}"
