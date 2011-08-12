# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
SRC_URI=""

inherit eutils
DESCRIPTION="Test package for the foo application"
HOMEPAGE="http://foo.bar.com/"
LICENSE=""
SLOT="2"
KEYWORDS="~amd64"
IUSE=""
DEPEND="app-text/bar[test]"
RDEPEND="${DEPEND}"

