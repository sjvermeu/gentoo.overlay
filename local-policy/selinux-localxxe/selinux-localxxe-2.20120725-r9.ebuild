# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="localxxe"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for apm"

KEYWORDS="~amd64 ~x86"
POLICY_FILES="localxxe.te localxxe.if localxxe.fc"
