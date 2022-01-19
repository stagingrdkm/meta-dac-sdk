SUMMARY = "LibNoVa"
LICENSE = "CLOSED"

CMF_GIT_PROTOCOL ?= "https"
CMF_GIT_ROOT ?= "git://code.rdkcentral.com/r"

SRC_URI += "\
  ${CMF_GIT_ROOT}/components/generic/avbus-poc;protocol=${CMF_GIT_PROTOCOL};branch=master;subpath=nova \
  file://0001_NoVa_openssl_api_change.patch \
  file://0002_CMakeList_versioning.patch \
"
SRCREV = "${AUTOREV}"
DEPENDS = "glib-2.0 openssl jsoncpp"
S = "${WORKDIR}/nova"
inherit cmake

EXTRA_OECMAKE += " -DPLATFORM=rdk-llama"

