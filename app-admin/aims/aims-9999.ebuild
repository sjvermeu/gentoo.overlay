# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Automatic Infrastructure Management System"
HOMEPAGE="http://localhost/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
  unpack ${FILESDIR}/aims.tar.gz
}
