# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openfoam-meta/openfoam-meta-1.5.ebuild,v 1.1 2009/04/25 16:28:29 patrick Exp $

DESCRIPTION="Meta package depending on all policies required for a Gentoo-based
SELinux system to function properly"
HOMEPAGE="http://oss.tresys.com/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="
		 ~sec-policy/selinux-portage-${PV}
		 " 
DEPEND="${RDEPEND}"
