SUMMARY = "LibRialtoClient"
LICENSE = "CLOSED"

CMF_GIT_PROTOCOL ?= "https"
CMF_GIT_ROOT ?= "git://code.rdkcentral.com/r"

SRC_URI += "\
  ${CMF_GIT_ROOT}/components/generic/avbus-poc;protocol=${CMF_GIT_PROTOCOL};branch=master;subpath=rialtoClient \
  file://0001_openssl_api_change.patch \
  file://0002_CMakeList_versioning.patch \
"
SRCREV = "${AUTOREV}"
DEPENDS = "glib-2.0 openssl jsoncpp"
S = "${WORKDIR}/rialtoClient"
inherit cmake

EXTRA_OECMAKE += " -DPLATFORM=rdk-llama"
