# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
SRC_URI="http://oss.tresys.com/files/refpolicy/refpolicy-2.20110726.tar.bz2
	http://dev.gentoo.org/~swift/patches/selinux-base-policy/patchbundle-selinux-base-policy-2.20110726-bug380271.tar.bz2"

inherit eutils

DESCRIPTION="Test package for bug #380271"
HOMEPAGE="http://foo.bar.com/"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S="${WORKDIR}/"

src_prepare() {
	epatch "${DISTDIR}/patchbundle-selinux-base-policy-2.20110726-bug380271.tar.bz2"
}

src_compile() {
	true;
}

src_install() {
	true;
}
