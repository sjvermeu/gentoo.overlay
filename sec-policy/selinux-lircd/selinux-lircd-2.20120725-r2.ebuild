# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="lircd"
BASEPOL="2.20120725-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for lircd"

KEYWORDS="~amd64 ~x86"