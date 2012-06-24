# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-djbdns/selinux-djbdns-2.20120215.ebuild,v 1.2 2012/04/29 10:11:57 swift Exp $
EAPI="4"

IUSE=""
MODS="djbdns"
BASEPOL="2.20120215-r13"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS="~amd64 ~x86"
DEPEND=">=sec-policy/selinux-daemontools-2.20120215"
RDEPEND="${DEPEND}"
