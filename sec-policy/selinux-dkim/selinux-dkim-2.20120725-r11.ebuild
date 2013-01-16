# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="dkim"
BASEPOL="2.20120725-r11"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dkim"

KEYWORDS="~amd64 ~x86"
DEPEND="${DEPEND}
	sec-policy/selinux-milter
"
RDEPEND="${DEPEND}"
