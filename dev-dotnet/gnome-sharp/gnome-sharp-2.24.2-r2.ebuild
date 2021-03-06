# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit dotnet autotools multilib

SLOT="2"
DESCRIPTION="gnome bindings for mono"
HOMEPAGE="http://www.mono-project.com/GtkSharp"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
SRC_URI="mirror://gnome/sources/gnome-sharp/2.24/${P}.tar.bz2"
IUSE="debug"

RESTRICT="test"

RDEPEND="
	>=dev-dotnet/gtk-sharp-2.12.21:2
	gnome-base/gconf
	gnome-base/libgnomecanvas
	gnome-base/libgnomeui
	media-libs/libart_lgpl
	!dev-dotnet/gnomevfs-sharp
	!dev-dotnet/gconf-sharp
	!dev-dotnet/art-sharp
	"
DEPEND="${RDEPEND}
	sys-devel/automake:1.11"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-fix-mono-path.patch

	default

	eautoreconf
	elibtoolize
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	default
	dotnet_multilib_comply
	sed -i "s#/usr/lib/#/usr/$(get_libdir)/#g" "${D}"/usr/bin/* || die "sed failed"
}
