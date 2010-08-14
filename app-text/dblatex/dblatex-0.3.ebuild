# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
# Not tested with Python 3.
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="dbtexmf"

inherit distutils

DESCRIPTION="Transform DocBook using TeX macros"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://dblatex.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/texlive
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-mathextra
	dev-texlive/texlive-xetex
	dev-libs/libxslt
	app-text/docbook-xml-dtd
	dev-texlive/texlive-pictures"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	newbin "${S}"/scripts/dblatex docbook2latex || die "newbin failed"
	mv "${D}"/usr/share/man/man1/dblatex.1.gz \
		"${D}"/usr/share/man/man1/docbook2latex.1.gz || die "mv dblatex.1.gz"
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${PF} || die "mv doc"

	einfo "This package installs its main binary as"
	einfo "  docbook2latex"
	einfo "to avoid collisions with other latex packages."
}
