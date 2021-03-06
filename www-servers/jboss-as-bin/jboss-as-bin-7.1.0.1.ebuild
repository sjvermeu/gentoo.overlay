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
	dodir /opt/redhat
	mv "${S}" "${D}"/opt/redhat/ || die
	mv "${D}/opt/redhat/jboss-as-${MY_PV}" "${D}/opt/redhat/jboss-as" || die

	newconfd "${FILESDIR}/jboss-as.conf" jboss-as
	newinitd "${FILESDIR}/jboss-as.init" jboss-as
}
