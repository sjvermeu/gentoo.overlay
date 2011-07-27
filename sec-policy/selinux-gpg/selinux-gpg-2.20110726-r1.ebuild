# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="gpg"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for GnuPG"
POLICY_PATCH="${FILESDIR}/fix-apps-gpg-r2.patch"
KEYWORDS="~amd64 ~x86"
