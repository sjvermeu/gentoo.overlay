# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.7 2010/01/23 11:29:38 aballier Exp $

EAPI=3

inherit eutils

DESCRIPTION="Tool to match installed software against the list of CVE entries"
HOMEPAGE="http://cvechecker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite mysql"

DEPEND="sqlite? ( >=dev-db/sqlite-3.6.23.1 )
	mysql? ( >=dev-db/mysql-5.1.51 )
	>=dev-libs/libconfig-1.3.2"
RDEPEND="${DEPEND}
	>=dev-libs/libxslt-1.1.26"

pkg_setup() {
	enewgroup cvechecker
}

src_configure() {
	econf \
		$(use_enable sqlite sqlite3) \
		$(use_enable mysql) || die "./configure failed"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	emake DESTDIR="${D}" postinstall || die
}
