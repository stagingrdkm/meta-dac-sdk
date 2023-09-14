TARGET_BUILD_TYPE = "ignition_with_device_layer"

AMAZON_SDK_URL = "http://127.0.0.1/avpk-v5.0.3.tgz;subdir=${PN}-${PV};name=avpk"
SRC_URI[avpk.md5sum] = "4a29b8bbb4a89da63db284b9e5efc05d"
SRC_URI[avpk.sha256sum] = "c4175531d07fa3381fdecdb301e6e08321a90d83f8262380feda5019712e3a02"

S = "${WORKDIR}/amazon-prime-src-5.0/amazonvideoportingkit/ignition/"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://0002-fix-iv.patch;patchdir=../../../git/rdk-linux-device-layer/implementation"
SRC_URI += "file://0003-ocdm-rialto.patch;patchdir=../../../git/rdk-linux-device-layer/implementation"
SRC_URI += "file://0004-DAC-fix.patch;patchdir=../../../git/rdk-linux-device-layer/implementation"

DEPENDS += "openssl c-ares nodejs-native caps wpeframework-ocdm-headers rialto-ocdm"
RDEPENDS_${PN} += "rdk-gstreamer-utils rialto-ocdm"

# appbootstrap is not delivered in tarball anymore so we need to generate
EXTRA_OECMAKE += " -DUSE_PRE_GENERATED_SOURCES=OFF"

# remove .git dir to fix issue install-app-assets.cmake will try to install build_info.txt
do_unpack_delete_git() {
   rm -rf ${WORKDIR}/amazon-prime-src-5.0/amazonvideoportingkit/.git
}
addtask unpack_delete_git after do_unpack before do_patch

LDFLAGS_remove = "-lcap"

# TODO: check why this is failing
INSANE_SKIP_${PN} += "installed-vs-shipped"

# use latest lgi-int branch
SRC_URI_remove = "${CMF_GIT_ROOT}/apps/amazon/AVPK5;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"
SRC_URI += "${CMF_GIT_ROOT}/apps/amazon/AVPK5;protocol=${CMF_GIT_PROTOCOL};branch=lgi-int"
SRCREV = "20a8da1c204fda1a76880e47e80047fae3af98e3"
