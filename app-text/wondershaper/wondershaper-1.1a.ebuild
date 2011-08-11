# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Wondershaper is a VoIP QoS script"
HOMEPAGE="http://lartc.org/wondershaper"
KEYWORDS="~amd64"
LICENSE="GPL-2"

SRC_URI="http://lartc.org/${PN}/${P}.tar.gz"
SLOT="0"
IUSE=""

RDEPEND="sys-apps/iproute2"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	doinitd "${S}"/wshaper
	doinitd "${S}"/wshaper.htb
	newconfd "${FILESDIR}"/wshaper.confd wshaper
	newconfd "${FILESDIR}"/wshaper.confd wshaper.htb
	dodoc ChangeLog README
}

pkg_postinst() {
	elog "The wondershaper script is installed as a Gentoo init script, called"
	elog "${ROOT}etc/init.d/wshaper (or wshaper.htb). To configure the script,"
	elog "please edit ${ROOT}etc/conf.d/wshaper (or wshaper.htb)."
}
