# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-squid/selinux-squid-2.20120215-r1.ebuild,v 1.2 2012/04/29 10:11:30 swift Exp $
EAPI="4"

IUSE=""
MODS="squid"
BASEPOL="2.20120215-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for squid"

KEYWORDS="~amd64 ~x86"
DEPEND=">=sec-policy/selinux-apache-2.20120215"
RDEPEND="${DEPEND}"
