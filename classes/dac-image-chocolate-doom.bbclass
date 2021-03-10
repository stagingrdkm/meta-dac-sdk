SUMMARY = "Base class for DAC chocolate-doom port"

inherit  dac-image-wayland

DISTRO_FEATURES_append = " wayland"

IMAGE_INSTALL_append = " libsdl2"

