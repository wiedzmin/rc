# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils git-r3 python-r1

DESCRIPTION="A double-entry accounting system with a command-line reporting interface"
HOMEPAGE="http://ledger-cli.org/"
EGIT_REPO_URI="https://github.com/ledger/ledger"
IUSE="debug doc emacs gnuplot libedit python static-libs vim-syntax experimental"

LICENSE="BSD"
SLOT="0"

DEPEND=">=dev-libs/boost-1.35:=[python?]
	dev-libs/gmp
	dev-libs/mpfr
	doc? ( sys-apps/texinfo )
	libedit? ( dev-libs/libedit )"
RDEPEND="${DEPEND}
	emacs? ( virtual/emacs )
	gnuplot? ( sci-visualization/gnuplot )
	vim-syntax? ( app-vim/ledger-syntax )"

# include test/input/drewr.dat as it is referenced by the manual
DOCS=(test/input/drewr.dat)

src_unpack() {
	use experimental && EGIT_BRANCH=next
	git-r3_src_unpack
}

src_prepare() {
	cmake-utils_src_prepare

	# disable autodetection for libedit
	# we will rely on the USE flag instead
	sed -i -e '/check_library_exists(edit readline "" HAVE_EDIT)/d' \
		"${S}/CMakeLists.txt" || die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build debug DEBUG)
		$(cmake-utils_use_build doc DOCS)
		$(cmake-utils_use_build doc WEB_DOCS)
		$(cmake-utils_use_has libedit EDIT)
		$(cmake-utils_use_use python PYTHON)
		$(cmake-utils_use_build python LIBRARY)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_make doc
}

src_install() {
	cmake-utils_src_install

	doman doc/ledger.1

	if use gnuplot; then
		mv contrib/report ledger-report
		dobin ledger-report
	fi

	if use doc; then
		dohtml "${BUILD_DIR}"/doc/ledger3.html
		dodoc -r contrib
	fi

	rm -rf "${ED}"/usr/share/doc/${PN}

	use emacs && elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
