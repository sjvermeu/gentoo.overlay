# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=4

inherit eutils

DESCRIPTION="Wondershaper is a VoIP QoS script"
HOMEPAGE="http://lartc.org/wondershaper"
SRC_URI="http://lartc.org/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64"

SKEL="${FILESDIR}/rc.skel-1.1a"
PATCH="${FILESDIR}/${P}-gentoo.patch"

src_prepare() {
	epatch "${PATCH}"
}

src_compile() {
	tail -n+2 wshaper \
	| awk '/^# Now remove/{firstPartOver=1}{if (! firstPartOver) print $0}' \
	>> wondershaper.config

	for i in wshaper*; do
		SCRIPT=${i/wshaper/wondershaper}
		cp ${SKEL} ${SCRIPT}
		awk '/^if \[/{firstPartOver=1}{if (firstPartOver) print $0}' ${i} \
		| awk '			{addOR=nextAddOR;
						 nextAddOR=0}
			/tc.*add/	{addOR=1}
			/\\$/		{nextAddOR=addOR;addOR=0}
						{printf("%s",$0);
						 if (addOR) print " || return 1"
						 else printf "\n"}' \
		| sed 's/exit/return 0/' >> ${SCRIPT}
		echo "}" >> ${SCRIPT}
	done
}

src_install() {
	exeinto /etc/init.d/
	doexe wondershaper wondershaper.htb
	insinto /etc/conf.d/
	newins wondershaper.config wondershaper
	dohard /etc/conf.d/wondershaper /etc/conf.d/wondershaper.htb
	dodoc ChangeLog README TODO COPYING VERSION
}

