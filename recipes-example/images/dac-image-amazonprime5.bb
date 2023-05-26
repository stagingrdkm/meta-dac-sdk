SUMMARY = "DAC Container with Amazon Prime 5.1"

inherit  dac-image-essos

IMAGE_INSTALL = "amazon-prime-src strace gstreamer1.0-plugins-base gstreamer1.0"

# needed
OCI_IMAGE_ENTRYPOINT = "/usr/bin/ignition"
#OCI_IMAGE_ENTRYPOINT = "/usr/bin/strace"
APP_METADATA_PATH = "metadatas/amazonprime5-appmetadata.json"


# optional
OCI_IMAGE_AUTHOR = "LGi"
OCI_IMAGE_AUTHOR_EMAIL = "info@lgi.com"
#OCI_IMAGE_ENTRYPOINT_ARGS = "--log-level=ALL:DEBUG"
OCI_IMAGE_ENTRYPOINT_ARGS = "--log-level=ALL:INFO"
#OCI_IMAGE_ENTRYPOINT_ARGS = "-f\\@\\-s\\@\\1000\\@\\/usr/bin/ignition"
OCI_IMAGE_WORKINGDIR = "/usr/persist/"
#OCI_IMAGE_WORKINGDIR = "/usr/bin/"
OCI_IMAGE_ENV_VARS += "GST_DEBUG_DUMP_DOT_DIR=/tmp/gst"
OCI_IMAGE_ENV_VARS += "GST_ENABLE_SVP=1"
#OCI_IMAGE_ENV_VARS += "GST_DEBUG="GST_CAPS:7,*:3,brcmvideosink:5,rialto*:5""
OCI_IMAGE_ENV_VARS += "GST_DEBUG="*:3""

#do_rootfs_append() {
#    from os import path, system
#
#    image_rootfs = str(d.getVar('IMAGE_ROOTFS'))
#
#    system(f"rm -rf %s/usr/lib/libWPEFramework*" % (image_rootfs))
#    system(f"rm -rf %s/usr/lib/wpeframework" % (image_rootfs))
#}

do_rootfs_append() {
    from os import path, system

    image_rootfs = str(d.getVar('IMAGE_ROOTFS'))

    system(f"mkdir -p %s/tmp/gst/" % (image_rootfs))
#    system(f"mkdir -p %s/var/run/dbus/" % (image_rootfs))
#    system(f"touch %s/var/run/dbus/system_bus_socket" % (image_rootfs))

#    system(f"mkdir -p %s/lib/" % (image_rootfs))
#    system(f"touch %s/lib/libsystemd.so.0" % (image_rootfs))
#    system(f"touch %s/lib/libcap.so.2" % (image_rootfs))

#    system(f"mkdir -p %s/usr/lib/" % (image_rootfs))
#    system(f"touch %s/usr/lib/libnexus.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libb_os.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libnxclient.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libsrai.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libcmndrm.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libcmndrm_tl.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libdrmrootfs.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libbcrypt.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/liblzma.so.5" % (image_rootfs))

#    system(f"touch %s/usr/lib/libIARMBus.so.0" % (image_rootfs))
#    system(f"touch %s/usr/lib/libdbus-1.so.3" % (image_rootfs))
#    system(f"touch %s/usr/lib/libepoxy.so.0.0.0" % (image_rootfs))
#    system(f"touch %s/usr/lib/libjansson.so.4" % (image_rootfs))
#    system(f"touch %s/usr/lib/libnxpl-nxclient.so.1.13.1" % (image_rootfs))
#    system(f"touch %s/usr/lib/libodherr.so.0" % (image_rootfs))
#    system(f"touch %s/usr/lib/libpwrstatewatcher.so.0.1.0" % (image_rootfs))
#    system(f"touch %s/usr/lib/libv3ddriver.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libv3dplatform.so" % (image_rootfs))
#    system(f"touch %s/usr/lib/libwayland-client.so.0" % (image_rootfs))

#    system(f"mkdir -p %s/usr/bin/" % (image_rootfs))
#    system(f"touch %s/usr/bin/sage_ta_netflix.bin" % (image_rootfs))
}
