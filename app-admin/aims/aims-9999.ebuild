# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Automatic Infrastructure Management System"
HOMEPAGE="http://localhost/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="
	sys-apps/mlocate
"

src_unpack() {
	mkdir aims-9999
}

src_prepare() {
	tar xvf ${FILESDIR}/aims.tar.gz -C ${S}
}

src_install() {
	mkdir -p ${ED}/usr/bin ${ED}/usr/lib/aims ${ED}/usr/libexec/aims ${ED}/etc/aims || die "Could not prepare directory structure"
	cp ${S}/bin/* ${ED}/usr/bin || die "Could not install binary scripts"
	cp -r ${S}/lib/* ${ED}/usr/lib/aims/ || die "Could not install lib files"
	cp -r ${S}/libexec/* ${ED}/usr/libexec/aims/ || die "Could not install libexec files"
	cp -r ${S}/conf/* ${ED}/etc/aims/ || die "Could not install conf files"
}
