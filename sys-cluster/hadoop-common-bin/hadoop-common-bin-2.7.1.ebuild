# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit user

DESCRIPTION="Apache Hadoop Common framework"
HOMEPAGE="http://hadoop.apache.org/"
MY_PN="hadoop"
SRC_URI="mirror://apache/hadoop/common/${MY_PN}-${PV}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="selinux"

DEPEND="
	virtual/jdk:*
"
RDEPEND="
	${DEPEND}
	selinux? ( sec-policy/selinux-hadoop )
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	enewgroup hadoop
	enewuser hdfs -1 /bin/bash /var/lib/hadoop/hdfs hadoop
	enewuser yarn -1 /bin/bash /var/lib/hadoop/hdfs hadoop
}

src_install() {
	# Setup directory structure
	diropts -m770 -o root -g hadoop
	dodir /var/log/"${MY_PN}"
	dodir /var/lib/"${MY_PN}"

	diropts -m770 -o hdfs -g hadoop
	dodir /var/lib/"${MY_PN}"/hdfs

	diropts -m755 -o root
	dodir /usr

	# Now install Hadoop binaries all over the place
	mv "${S}"/{bin,include,lib,libexec,sbin,share} "${ED}/usr" || die "Installation of Apache Hadoop files failed"
	mv "${S}"/etc "${ED}/" || die "Installation of Hadoop configuration failed"

	# Install the service specific scripts
	newinitd "${FILESDIR}/hadoop-namenode" hadoop-namenode
	newinitd "${FILESDIR}/hadoop-datanode" hadoop-datanode
	newinitd "${FILESDIR}/hadoop-resourcemanager" hadoop-resourcemanager
	newinitd "${FILESDIR}/hadoop-nodemanager" hadoop-nodemanager
	newconfd "${FILESDIR}/hadoop" hadoop
}
