# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.7 2010/01/23 11:29:38 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Simple hex/checksum output to string convertor"
HOMEPAGE="http://swift.siphos.be/tools-hex2passwd.html"
SRC_URI="http://swift.siphos.be/tools/hex2passwd/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${P}
	emake CC="$(tc-getCC)" || die
}

src_install() {
	cd ${P}
	dobin hex2passwd || die
	doman hex2passwd.1 || die
}
