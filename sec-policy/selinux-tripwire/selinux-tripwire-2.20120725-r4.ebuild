# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="tripwire"
BASEPOL="2.20120725-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for tripwire"

KEYWORDS="~amd64 ~x86"