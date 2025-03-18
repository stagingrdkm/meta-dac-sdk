# disable server parts
PACKAGECONFIG_remove = "servermanager-sim"

require rialto_revision.inc

SRCREV = "${RIALTO_VERSION}"
