SUMMARY = "DAC Container with Netflix 6.1"

inherit  dac-image-essos

IMAGE_INSTALL = "netflix"

# needed
OCI_IMAGE_ENTRYPOINT = "/usr/bin/netflix"
APP_METADATA_PATH = "metadatas/netflix6-appmetadata.json"

# optional
OCI_IMAGE_AUTHOR = "LGi"
OCI_IMAGE_AUTHOR_EMAIL = "info@lgi.com"
OCI_IMAGE_ENTRYPOINT_ARGS = "-a\\@\\/tmp/netflix/appbootkey.txt\\@\\-l\\@\\debug\\@\\--gl-client-version=3.0"
OCI_IMAGE_WORKINGDIR = "/home/netflix"
OCI_IMAGE_ENV_VARS += "HOME=/home/netflix/"
OCI_IMAGE_ENV_VARS += "NF_DATA_DIR=/home/netflix/data"
OCI_IMAGE_ENV_VARS += "NF_WRITE_DATA_PATH=/opt/netflix"
OCI_IMAGE_ENV_VARS += "NETFLIX_VAULT=/tmp/netflix/netflix.key"
