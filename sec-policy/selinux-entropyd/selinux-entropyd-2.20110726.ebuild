# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

IUSE=""
MODS="entropyd"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for various entropy daemons (audio-entropyd, haveged, ...)"

KEYWORDS="~amd64 ~x86"
RDEPEND="!<sec-policy/selinux-audio-entropyd-2.20110726
		>=sys-apps/policycoreutils-1.30.30
		>=sec-policy/selinux-base-policy-${PV}"
