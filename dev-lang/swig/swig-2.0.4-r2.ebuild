# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-2.0.4-r1.ebuild,v 1.10 2012/04/26 20:39:51 aballier Exp $

EAPI=3

inherit base

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3 as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ccache doc pcre"
RESTRICT="test"

DEPEND="pcre? ( dev-libs/libpcre )
		ccache? ( sys-libs/zlib )"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-typedef.patch
	"${FILESDIR}"/${P}-pyint_fromsize_declaration.patch
	)

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable ccache) \
		$(use_with pcre)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES CHANGES.current README TODO || die
	if use doc; then
		dohtml -r Doc/{Devel,Manual} || die
	fi
}
