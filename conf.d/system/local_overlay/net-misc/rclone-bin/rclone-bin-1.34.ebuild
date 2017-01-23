# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION='Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox, ...'
HOMEPAGE='http://rclone.org/'
LICENSE='MIT'

PN_NO_BIN="${PN%-bin}"
SLOT='0'
src_uri_base="http://downloads.rclone.org/${PN_NO_BIN}-v${PV}-linux"
SRC_URI="
	amd64?	( ${src_uri_base}-amd64.zip )
	arm?	( ${src_uri_base}-arm.zip )
"

KEYWORDS='-* ~amd64 ~arm'

RDEPEND="!!${CATEGORY}/${PN_NO_BIN}"

RESTRICT="mirror"

src_unpack() {
	default
	cd "${WORKDIR}"/${PN_NO_BIN}-*/ || die
	S="${PWD}"
}

inst_d="/opt/${PN_NO_BIN}"
QA_PRESTRIPPED="${inst_d#/}/bin/${PN_NO_BIN}"

src_install() {
	into "${inst_d}"
	dobin "${PN_NO_BIN}"
	dosym "${inst_d}/bin/${PN_NO_BIN}" "/usr/bin/${PN_NO_BIN}"

	doman "${PN_NO_BIN}.1"
	dodoc README.*
}
