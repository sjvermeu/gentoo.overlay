# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-entropyd/selinux-entropyd-2.20120215.ebuild,v 1.2 2012/04/29 10:11:40 swift Exp $
EAPI="4"

IUSE=""
MODS="entropyd"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for various entropy daemons (audio-entropyd, haveged, ...)"

KEYWORDS="amd64 x86"

pkg_postinst() {
	einfo "The SELinux entropyd module is the replacement of audioentropyd and"
	einfo "is made more generic for all-purpose entropy daemons, including"
	einfo "audioentropyd and haveged."
	einfo
	einfo "If you are upgrading from an audioentropyd module, the installation"
	einfo "of the new policy module might fail due to collisions. You will need"
	einfo "to remove the current audioentropyd module first:"
	einfo "  # semodule -r audioentropy"
	einfo
	einfo "Then, you can install the new policy:"
	einfo "  # semodule -i /usr/share/selinux/<type>/entropyd.pp"
	echo
	einfo "Portage will automatically try to load the entropyd module now."
	selinux-policy-2_pkg_postinst
}
