# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="nginx"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for nginx"
POLICY_PATCH="${FILESDIR}/fix-services-nginx-2.20110726-r1.patch"
KEYWORDS="~amd64 ~x86"
