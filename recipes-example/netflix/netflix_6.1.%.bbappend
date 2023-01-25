INSANE_SKIP_${PN} += "ldflags"

# switch to lgi-int branch
SRC_URI_remove = "${CMF_GIT_ROOT}/apps/netflix/netflix-6.1;protocol=${CMF_GIT_PROTOCOL};branch=rdk-dev;name=netflix"
SRC_URI += "${CMF_GIT_ROOT}/apps/netflix/netflix-6.1;protocol=${CMF_GIT_PROTOCOL};branch=lgi-int;name=netflix"

inherit codecentral_cherry_picking
# add ICrypto support
CODECENTRAL_CHERRY_PICKS += "79678/revisions/220d41ebed512da141610a3a8a40e738dc9d130c icrypto.patch;patchdir=${S}/../../../git/"
DEPENDS += "wpeframework-clientlibraries"

# fix small issue in EGL driver
CODECENTRAL_CHERRY_PICKS += "79772/revisions/c5ad3a00976013dfe63fafc61428269afa330fa6 egldriver.patch;patchdir=${S}/../../../git/"

# skipped for PSEUDO issue
INHIBIT_PACKAGE_DEBUG_SPLIT="1"
