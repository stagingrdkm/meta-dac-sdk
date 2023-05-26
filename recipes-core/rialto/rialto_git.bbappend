# disable server parts
PACKAGECONFIG_remove = "server"
PACKAGECONFIG_remove = "servermanager"

# 4 Apr 2023
#SRCREV = "6a0e9c2416461f9b42a190fa1de0cedbd25d2974"

SRC_URI += "file://0001-rialto-server-codec-data-string.patch"
SRC_URI += "file://0002-playready-fix.patch"
