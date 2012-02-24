# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-inetd/selinux-inetd-2.20110726-r1.ebuild,v 1.2 2011/12/19 18:17:16 swift Exp $
EAPI="4"

IUSE=""
MODS="inetd"
BASEPOL="2.20110726-r6"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for inetd"

KEYWORDS="amd64 x86"
