SUMMARY = "DAC chocolate-doom port"

inherit  dac-image-sdl

IMAGE_INSTALL = "chocolate-doom"

# needed
OCI_IMAGE_ENTRYPOINT = "/usr/bin/chocolate-doom"
APP_METADATA_PATH = "metadatas/chocolate-doom-appmetadata.json"

# optional
OCI_IMAGE_AUTHOR = "LGi"
OCI_IMAGE_AUTHOR_EMAIL = "info@lgi.com"
OCI_IMAGE_ENTRYPOINT_ARGS = ""
OCI_IMAGE_WORKINGDIR = "/"
