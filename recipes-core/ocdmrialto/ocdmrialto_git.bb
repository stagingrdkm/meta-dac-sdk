SUMMARY = "ocdmRialto"
LICENSE = "CLOSED"

CMF_GIT_PROTOCOL ?= "https"
CMF_GIT_ROOT ?= "git://code.rdkcentral.com/r"

SRC_URI += "\
  ${CMF_GIT_ROOT}/components/generic/avbus-poc;protocol=${CMF_GIT_PROTOCOL};branch=master;subpath=ocdmRialto \
  file://0001-Remove-Wpe.patch \
  file://0002-Add-OCDM-Headers.patch \
  file://0003-CMake-PackageConfig.patch \
"

SRCREV = "${AUTOREV}"
DEPENDS = "librialtoclient"
S = "${WORKDIR}/ocdmRialto"
inherit cmake

RPROVIDES_${PN} += "libocdmRialto.so"
