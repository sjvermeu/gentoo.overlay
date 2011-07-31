# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="zabbix"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for zabbix"
POLICY_PATCH="${FILESDIR}/fix-services-zabbix-2.20110726-r1.patch"
BASEPOL="2.20110726-r1"
KEYWORDS="~amd64 ~x86"
