# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-emulator/tpm-emulator-0.5.1.ebuild,v 1.3 2012/05/31 03:31:59 zmedico Exp $

EAPI=2
inherit toolchain-funcs linux-mod eutils multilib user

MY_P=${P/-/_}
DESCRIPTION="Emulator driver for tpm"
HOMEPAGE="https://developer.berlios.de/projects/tpm-emulator"

SRC_URI="mirror://berlios/tpm-emulator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="modules"
DEPEND="
	dev-libs/gmp
	dev-util/cmake"
RDEPEND=""
S="${WORKDIR}"/${P/-/_}

#fixups at:
#https://developer.berlios.de/feature/index.php?func=detailfeature&feature_id=3304&group_id=2491

pkg_setup() {
	use modules && linux-mod_pkg_setup
	MODULE_NAMES="tpmd_dev(crypt::${S}/tpmd_dev)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="CC=$(tc-getCC)"
	enewuser tss -1 -1 /var/lib/tpm tss
}

src_compile() {
	emake 
	if use modules; then
		linux-mod_src_compile || die "Failed to build kernelspace"
	fi
}

src_install() {
	if [ -x /usr/bin/scanelf -a -f tpm_emulator.ko ]; then
		[ -z "$(/usr/bin/scanelf -qs __guard tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
		[ -z "$(/usr/bin/scanelf -qs __stack_smash_handler tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
	fi

	use modules && linux-mod_src_install

	#emake install DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" \
	emake install 

	newinitd "${FILESDIR}"/${PN}.initd-0.5.1 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd-0.5.1 ${PN}

	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/${PN}.udev 60-${PN}.rules

	keepdir /var/run/tpm
	fowners tss /var/run/tpm

	keepdir /var/log/tpm
	fowners tss:tss /var/log/tpm
}
