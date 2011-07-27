# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="links"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for links"
POLICY_PATCH="${FILESDIR}/add-apps-links.patch"
KEYWORDS="~amd64 ~x86"
