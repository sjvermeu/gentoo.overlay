# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-uucp/selinux-uucp-2.20120215.ebuild,v 1.3 2012/06/04 19:05:17 swift Exp $
EAPI="4"

IUSE=""
MODS="uucp"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for uucp"
KEYWORDS="amd64 x86"
DEPEND=">=sec-policy/selinux-inetd-2.20120215"
RDEPEND="${DEPEND}"
