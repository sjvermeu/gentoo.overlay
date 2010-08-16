# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.7 2010/01/23 11:29:38 aballier Exp $

EAPI=3

inherit eutils

DESCRIPTION="Tool to match installed software against the list of CVE entries"
HOMEPAGE="http://cvechecker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/development/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/sqlite-3.6.23.1
	>=dev-libs/libconfig-1.3.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup cvechecker
	enewuser cvechecker -1 -1 -1 cvechecker
}

src_install() {
	dobin cvechecker pullcves || die
	doman cvechecker.1 || die

	diropts -p -m775 -o cvechecker -g cvechecker
	dodir /var/lib/cvechecker
	dodir /var/db/cvechecker{,/{local,cache}}

	insinto /etc
	doins cvechecker.conf || die

	insinto /var/lib/cvechecker
	doins nvdcve2simple.xsl || die
}
