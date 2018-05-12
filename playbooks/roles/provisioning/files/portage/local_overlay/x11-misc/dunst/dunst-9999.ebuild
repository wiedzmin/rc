# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="lightweight and customizable notification daemon"
HOMEPAGE="https://dunst-project.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/knopwob/dunst.git"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/glib
dev-libs/libxdg-basedir
sys-apps/dbus
x11-libs/cairo
x11-libs/gtk+:2
x11-libs/libXScrnSaver
x11-libs/libXft
x11-libs/libXinerama
x11-libs/libXrandr
x11-libs/pango"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
  for f in README.md CHANGELOG.md RELEASE_NOTES; do
    dodoc "$f"
  done
}
