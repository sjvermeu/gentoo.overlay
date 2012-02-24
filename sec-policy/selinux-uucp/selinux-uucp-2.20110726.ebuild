# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-uucp/selinux-uucp-2.20110726.ebuild,v 1.2 2012/01/29 11:23:11 swift Exp $
EAPI="4"

IUSE=""
MODS="uucp"
BASEPOL="2.20110726-r7"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for uucp"
KEYWORDS="amd64 x86"
