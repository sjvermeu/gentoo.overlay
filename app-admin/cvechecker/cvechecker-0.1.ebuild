# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.7 2010/01/23 11:29:38 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Tool to match installed software against the list of CVE entries"
HOMEPAGE="http://cvechecker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/development/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/sqlite-3.6.23.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup cvechecker
	enewuser cvechecker -1 -1 -1 cvechecker
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${P}
	econf || die "econf failed"
	emake CC="$(tc-getCC)" || die
}

src_install() {
	cd ${P}
	dobin cvechecker || die
	dobin pullcves || die
	doman cvechecker.1 || die
	dodir /var/lib/cvechecker
	dodir /var/db
	dodir /var/db/cvechecker
	dodir /var/db/cvechecker/local
	dodir /var/db/cvechecker/cache
	insinto /etc
	doins cvechecker.conf || die
	insinto /var/lib/cvechecker
	doins nvdcve2simple.xsl
}

pkg_postinst() {
	chown cvechecker:cvechecker /var/db/cvechecker
	chmod g+w /var/db/cvechecker
	chown cvechecker:cvechecker /var/db/cvechecker/local
	chmod g+w /var/db/cvechecker/local
	chown cvechecker:cvechecker /var/db/cvechecker/cache
	chmod g+w /var/db/cvechecker/cache
}
