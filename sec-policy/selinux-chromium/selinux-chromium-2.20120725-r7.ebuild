# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="chromium"
BASEPOL="2.20120725-r7"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for chromium"

KEYWORDS="~amd64 ~x86"
DEPEND="${DEPEND}
	sec-policy/selinux-xdg
"
RDEPEND="${DEPEND}"
