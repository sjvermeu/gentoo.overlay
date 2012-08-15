# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="ipsec"
BASEPOL="2.20120725-r3"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ipsec"

KEYWORDS="~amd64 ~x86"
