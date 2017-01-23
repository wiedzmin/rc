# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

EGIT_REPO_URI="https://github.com/rizsotto/Bear.git"

DESCRIPTION="Bear is a tool to generate compilation databases for clang tooling."
HOMEPAGE="https://github.com/rizsotto/Bear"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND=">=dev-libs/libconfig-1.4"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}"/etc
	)
	cmake-utils_src_configure
}
