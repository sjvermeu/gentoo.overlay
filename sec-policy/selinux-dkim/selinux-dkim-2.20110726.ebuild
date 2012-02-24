# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dkim/selinux-dkim-2.20110726.ebuild,v 1.2 2011/10/23 12:42:39 swift Exp $
EAPI="4"

IUSE=""
MODS="dkim"
DEPEND=">=sec-policy/selinux-base-policy-2.20110726-r1
	>=sec-policy/selinux-milter-2.20110726"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dkim"

KEYWORDS="amd64 x86"
