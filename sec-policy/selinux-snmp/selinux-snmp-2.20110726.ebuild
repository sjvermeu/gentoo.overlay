# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snmp/selinux-snmp-2.20110726.ebuild,v 1.2 2011/10/23 12:42:35 swift Exp $
EAPI="4"

IUSE=""
MODS="snmp"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for snmp"
KEYWORDS="amd64 x86"
RDEPEND=">=sec-policy/selinux-base-policy-2.20110726-r1
	!<sec-policy/selinux-snmpd-2.20110726"
