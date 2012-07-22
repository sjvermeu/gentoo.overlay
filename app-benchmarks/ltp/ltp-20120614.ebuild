# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/ltp/ltp-20100131.ebuild,v 1.2 2010/11/10 19:12:57 patrick Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Linux Test Project: testsuite for the linux kernel"
HOMEPAGE="http://ltp.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python apm rt"

MY_P="${PN}-full-${PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="mirror://sourceforge/project/ltp/LTP%20Source/${P}/${MY_P}.bz2 -> ${MY_P}.tar.bz2"

src_configure() {
	local myconf

	econf $(use_enable perl) \
		$(use_enable python) \
		$(use_enable apm power-management-testsuite) \
		$(use_enable rt realtime-testsuite)
}
