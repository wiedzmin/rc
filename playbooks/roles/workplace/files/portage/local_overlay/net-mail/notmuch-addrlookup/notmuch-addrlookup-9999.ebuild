# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Notmuch Address Lookup tool"
HOMEPAGE="https://github.com/aperezdc/notmuch-addrlookup-c"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aperezdc/notmuch-addrlookup-c.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-mail/notmuch
dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_install() {
	dobin notmuch-addrlookup
	dodoc README.md
}

