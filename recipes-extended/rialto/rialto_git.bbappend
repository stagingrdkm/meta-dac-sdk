# disable server parts
PACKAGECONFIG_remove = "server"
PACKAGECONFIG_remove = "servermanager"

RDEPENDS_${PN}_remove = "mongoose"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-Remove-wrappers-from-compilation.patch"
