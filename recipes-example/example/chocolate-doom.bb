
SUMMARY = "Chocolate Doom game"
DESCRIPTION = "Chocolate Doom game which is port of DOS game Doom"
LICENSE = "GPL"
LIC_FILES_CHKSUM = "file://COPYING.md;md5=60d644347832d2dd9534761f6919e2a6"

DEPENDS = "virtual/libsdl2 libsdl2-mixer libsdl2-net pkgconfig"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

TARGET_CFLAGS     += " -fomit-frame-pointer "

S = "${WORKDIR}/git/"

SRC_URI = " \
    git://github.com/chocolate-doom/chocolate-doom.git;protocol=http;branch=master;rev=a378d0288a77ef8efff439c5e250e82b03e2c502 \
    file://sdl_gl_setattribute.patch \
    file://doom1.wad \
    "

inherit autotools pkgconfig

do_install_append() {
    install -m 0644 ${WORKDIR}/doom1.wad ${D}${datadir}
}

FILES_${PN} += "${datadir}/*"
