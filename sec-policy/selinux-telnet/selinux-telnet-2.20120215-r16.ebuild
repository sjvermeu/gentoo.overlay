# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="telnet"
BASEPOL="2.20120215-r16"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for telnet"

KEYWORDS="~amd64 ~x86"
DEPEND="${DEPEND}
	sec-policy/selinux-remotelogin
"
RDEPEND="${DEPEND}"
