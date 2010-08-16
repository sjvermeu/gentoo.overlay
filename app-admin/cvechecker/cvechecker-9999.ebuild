# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.7 2010/01/23 11:29:38 aballier Exp $

EAPI=3

inherit eutils

DESCRIPTION="Tool to match installed software against the list of CVE entries"
HOMEPAGE="http://cvechecker.sourceforge.net"
if [[ $PV == 9999 ]]; then
	ESVN_REPO_URI="https://cvechecker.svn.sourceforge.net/svnroot/cvechecker"
	inherit autotools subversion
else
	SRC_URI="mirror://sourceforge/${PN}/development/${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/sqlite-3.6.23.1
	>=dev-libs/libconfig-1.3.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup cvechecker
}

src_prepare() {
	if [[ $PV == 9999 ]]; then
		eautoreconf
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	chgrp cvechecker "${D}"/var/lib/cvechecker{,/{local,cache}} || die
	chmod 0775 "${D}"/var/lib/cvechecker{,/{local,cache}} || die

	# Changing settings in cvechecker.conf. Config file protection
	# should ensure that we will not automatically overwrite a user preference
	# here
	sed -i -e "s:/usr/local/var/:/var/lib/:g" "${D}"/etc/cvechecker.conf
	sed -i -e "s:/usr/local/share/:/usr/share/:g" "${D}"/etc/cvechecker.conf
}
