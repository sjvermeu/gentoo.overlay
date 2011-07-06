# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.0.94.ebuild,v 1.5 2011/05/28 05:24:03 blueness Exp $

EAPI="2"
PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit multilib python toolchain-funcs eutils

SEPOL_VER="2.0.41"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20100525/devel/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python ruby"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	ruby? ( dev-lang/ruby )"
DEPEND="${RDEPEND}
	dev-lang/swig"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}/libselinux-2.0.94-python3.patch"
	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	if use python; then
		python_copy_sources src
		building() {
			emake CC="$(tc-getCC)" PYLIBVER="python$(python_get_version)" LDFLAGS="-fPIC ${LDFLAGS}" "$@"
		}
		python_execute_function -s --source-dir src building
		#python_execute_function -s --source-dir src building -- swigify
		python_execute_function -s --source-dir src building -- pywrap
	fi

	if use ruby; then
		emake CC="$(tc-getCC)" rubywrap || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		installation() {
			emake DESTDIR="${D}" PYLIBVER="python$(python_get_version)" install-pywrap
		}
		python_execute_function -s --source-dir src installation
	fi

	if use ruby; then
		emake DESTDIR="${D}" install-rubywrap || die
	fi
}

pkg_postinst() {
	if use python; then
		python_mod_optimize selinux
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup selinux
	fi
}
