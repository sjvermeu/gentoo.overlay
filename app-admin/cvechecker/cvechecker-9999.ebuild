# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils user

DESCRIPTION="Tool to match installed software against the list of CVE entries"
HOMEPAGE="http://cvechecker.sourceforge.net"
if [[ $PV == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/sjvermeu/cvechecker.git"
	inherit autotools git-r3
else
	SRC_URI="https://github.com/sjvermeu/cvechecker/archive/v${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite mysql"

DEPEND="sqlite? ( >=dev-db/sqlite-3.6.23.1 )
	mysql? ( >=dev-db/mysql-5.1.51 )
	>=dev-libs/libconfig-1.3.2"
RDEPEND="${DEPEND}
	>=dev-libs/libxslt-1.1.26
	>=app-misc/jq-1.6-r3"

pkg_setup() {
	enewgroup cvechecker
}

src_prepare() {
	if [[ $PV == 9999 ]]; then
		eautoreconf
	fi

	default
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
