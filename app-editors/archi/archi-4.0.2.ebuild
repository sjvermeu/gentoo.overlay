# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
S="${WORKDIR}/Archi"

DESCRIPTION="The Archi ArchiMate modelling tool"

SRC_URI="http://www.archimatetool.com/downloads/release/v4/Archi-Linux64-${PV}.tar.gz"

HOMEPAGE="http://www.archimatetool.com"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.7.0"
DEPEND=""
INSTALLDIR=/opt/${PN}

src_install() {
	dodir ${INSTALLDIR}
	cp -pPR "${S}"/* "${D}"/${INSTALLDIR}

	insinto /usr/share/applications
	doins "${FILESDIR}"/Archi.desktop
}
