# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/openscap/openscap-0.8.0.ebuild,v 1.2 2011/12/28 14:01:19 swift Exp $

EAPI=4

EGIT_REPO_URI="git://linux-ima.git.sourceforge.net/gitroot/linux-ima/ima-evm-utils.git"
EGIT_BOOTSTRAP="autogen.sh"

inherit git-2 eutils

DESCRIPTION="Supporting tools for IMA and EVM"
HOMEPAGE="http://linux-ima.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
