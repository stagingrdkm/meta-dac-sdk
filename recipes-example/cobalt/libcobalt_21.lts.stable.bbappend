# substitutte westeros dependency with essos stub library from SDK
DEPENDS_remove = "wpeframework-clientlibraries"
DEPENDS_remove = "westeros"
DEPENDS_append = " essos"
DEPENDS_append = " libnova"
DEPENDS_append = " libnova-ocdm"

CMF_GIT_PROTOCOL ?= "https"
CMF_GIT_ROOT ?= "git://code.rdkcentral.com/r"

SRCREV_cobalt = "21.lts.6"
SRCREV_depottools = "913305037df7027dc118253b7c2d3655d181c612"

# Nov 19, 2021
SRCREV_starboard = "c32bcd7760adb143ad041818800c65cc35abddf3"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://libcobalt-21.lts.stable-6.patch"
SRC_URI += "file://0002_Remove_Thunder.patch"

INSANE_SKIP_${PN} += "ldflags"

RDEPENDS_${PN} += "libnova"
RDEPENDS_${PN} += "libnova-ocdm"

do_configure() {
    export COBALT_HAS_OCDM="1"
    export COBALT_OCDM_LIBRARY_NAME="ocdm-NoVA"
    export COBALT_ARM_CALLCONVENTION="${@bb.utils.contains('TUNE_FEATURES', 'callconvention-hard', 'hardfp', 'softfp', d)}"
    ${S}/src/cobalt/build/gyp_cobalt -C qa -C gold -C devel ${COBALT_PLATFORM}
}

