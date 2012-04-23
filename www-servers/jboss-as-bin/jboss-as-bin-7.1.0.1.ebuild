# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

DESCRIPTION="Binary installation of JBoss Application Server"
HOMEPAGE="http://www.jboss.org/jbossas"
MY_PV="7.1.0.CR1b"
SRC_URI="http://download.jboss.org/jbossas/7.1/jboss-as-${MY_PV}/jboss-as-${MY_PV}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="selinux"

RDEPEND="selinux? ( sec-policy/selinux-jbossas )
		virtual/jdk"
DEPEND="selinux? ( sec-policy/selinux-jbossas )"

S="${WORKDIR}/jboss-as-${MY_PV}"

src_unpack() {
	unpack ${A}
}

src_install() {
	# Install JBoss AS in /opt
	dodir /opt/redhat/jboss-as
	mv "${S}/*" "${D}"/opt/redhat/jboss-as || die

	doconfd "${FILESDIR}/jboss-as.conf" jboss-as
	doinitd "${FILESDIR}/jboss-as.init" jboss-as
}
