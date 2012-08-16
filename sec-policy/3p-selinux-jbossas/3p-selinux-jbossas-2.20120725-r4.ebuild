# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-screen/selinux-screen-2.20120215.ebuild,v 1.1 2012/03/31 12:29:24 swift Exp $
EAPI="4"

IUSE=""
MODS="jbossas"
BASEPOL="2.20120725-r4"
POLICY_FILES="jbossas.te jbossas.fc jbossas.if"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for JBoss AS"

KEYWORDS="~amd64 ~x86"
