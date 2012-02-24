# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-zabbix/selinux-zabbix-2.20110726-r2.ebuild,v 1.2 2011/10/23 12:42:45 swift Exp $
EAPI="4"

IUSE=""
MODS="zabbix"
BASEPOL="2.20110726-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for zabbix"
KEYWORDS="amd64 x86"
