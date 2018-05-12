# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit git-2 autotools

DESCRIPTION="Very simple layout switcher"
HOMEPAGE="http://github.com/wiedzmin/kbdd"
SRC_URI=""

EGIT_REPO_URI="git://github.com/wiedzmin/kbdd.git
			https://github.com/wiedzmin/kbdd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus debug"

DEPEND="dev-libs/glib
		x11-libs/libX11
		dbus? (
			sys-apps/dbus
			>=dev-libs/dbus-glib-0.86
			)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/wiedzmin-kbdd"

src_prepare() {
	eautoreconf
}
src_configure() {
	econf $(use_enable dbus) $(use_enable debug) || die "econf failed"
}
