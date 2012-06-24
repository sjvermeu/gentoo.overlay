# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mozilla/selinux-mozilla-2.20120215-r2.ebuild,v 1.2 2012/06/01 17:39:49 swift Exp $
EAPI="4"

IUSE=""
MODS="mozilla"
BASEPOL="2.20120215-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mozilla"
KEYWORDS="~amd64 ~x86"
DEPEND=">=sec-policy/selinux-xserver-2.20120215"
RDEPEND="${DEPEND}"
