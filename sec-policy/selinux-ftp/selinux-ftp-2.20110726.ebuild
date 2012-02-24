# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftp/selinux-ftp-2.20110726.ebuild,v 1.2 2011/10/23 12:42:27 swift Exp $
EAPI="4"

IUSE=""
MODS="ftp"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ftp"
KEYWORDS="amd64 x86"
RDEPEND=">=sec-policy/selinux-base-policy-2.20110726-r1
	!<sec-policy/selinux-ftpd-2.20110726"
