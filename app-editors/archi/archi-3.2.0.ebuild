# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xxe/xxe-4.5.0.ebuild,v 1.1 2009/11/21 12:36:16 patrick Exp $

EAPI="5"
S="${WORKDIR}/Archi"

DESCRIPTION="The Archi ArchiMate modelling tool"

SRC_URI="http://www.archimatetool.com/downloads/latest/Archi-lnx32_64-${PV}.tar.gz"

HOMEPAGE="http://www.archimatetool.com"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=virtual/jre-1.7.0"
DEPEND=""
INSTALLDIR=/opt/${PN}

src_install() {
	dodir ${INSTALLDIR}
	cp -pPR "${S}"/* "${D}"/${INSTALLDIR}

	insinto /usr/share/applications
	doins "${FILESDIR}"/Archi.desktop

