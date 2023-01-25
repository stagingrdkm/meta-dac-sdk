# ============================================================================
# Copyright (c) 2023 Liberty Global. All rights reserved.
# ============================================================================
#

do_patch[prefuncs] += "do_patch_cherrypick_codecentral"

python do_patch_cherrypick_codecentral() {
    import os,netrc,urllib,shutil,re

    workdir = d.getVar("WORKDIR", True)
    patches_dir = workdir + "/rdk_patches"
    cookies_file = workdir + "/cookies.txt"
    rdk_user = urllib.parse.quote_plus(netrc.netrc().authenticators('code.rdkcentral.com')[0])
    rdk_password = urllib.parse.quote_plus(netrc.netrc().authenticators('code.rdkcentral.com')[2])

    # parse CODECENTRAL_CHERRY_PICKS
    cherrypicks = d.getVar("CODECENTRAL_CHERRY_PICKS", True)
    if cherrypicks is None:
        cherrypicks = []
    else:
        cherrypicks = cherrypicks.split(" ")
        cherrypicks = [cp for cp in cherrypicks if cp.strip()]

    if len(cherrypicks) % 2 != 0:
        bb.error("Bad number of entries in CODECENTRAL_CHERRY_PICKS")
        sys.exit(1)

    # parse CODECENTRAL_CHERRY_PICKS_R
    cherrypicks_and_replace = d.getVar("CODECENTRAL_CHERRY_PICKS_R", True)
    if cherrypicks_and_replace is None:
        cherrypicks_and_replace = []
    else:
        cherrypicks_and_replace = cherrypicks_and_replace.split(" ")
        cherrypicks_and_replace = [cp for cp in cherrypicks_and_replace if cp.strip()]

    if len(cherrypicks_and_replace) % 2 != 0:
        bb.error("Bad number of entries in CODECENTRAL_CHERRY_PICKS_R")
        sys.exit(1)

    patches_to_download = []
    patches_to_download.extend(cherrypicks)
    patches_to_download.extend(cherrypicks_and_replace)

    if len(patches_to_download) == 0:
        return

    # cleanup rdk patches dir
    if os.path.isdir(patches_dir):
        shutil.rmtree(patches_dir)
    os.mkdir(patches_dir)

    # login to rdk codecentral
    ret = os.system("wget --save-cookies " + cookies_file + " --keep-session-cookies --post-data 'username=" + rdk_user + "&password=" + rdk_password + "' --delete-after https://code.rdkcentral.com/r/login")
    if ret!=0:
        bb.error("Error logging into rdk codecentral")
        sys.exit(1)

    # download all patches
    for i in range(int(len(patches_to_download) / 2)):
        url = "https://code.rdkcentral.com/r/changes/" + patches_to_download[i*2] + "/patch"
        patchname = patches_to_download[(i*2) + 1]
        patchname = patchname.split(";")[0]
        ret = os.system("wget -O - --load-cookies " + cookies_file + " " + url + " | base64 --decode > " + patches_dir + "/cherry_picked_" + patchname)
        if ret!=0:
            bb.error("Error downloading patch %s from rdk codecentral %s" % (patchname, url))
            sys.exit(1)
    os.remove(cookies_file)

    d.prependVar('FILESEXTRAPATHS', patches_dir + ':')
    # SRC_URI all cherrypicked patches
    for i in range(int(len(cherrypicks) / 2)):
        # prepend in reverse order to keep cherry pick order and put them before regular patches
        idx = len(cherrypicks) - ((i*2) + 1)
        patchname = "cherry_picked_" + cherrypicks[idx]
        d.prependVar('SRC_URI', 'file://' + patchname + ' ')

    if len(cherrypicks_and_replace) > 0:
        # find all cherrypicked_and_replace patches inside SRC_URI and replace "in-place"
        # to pre-serve ordering
        src_uri = d.getVar('SRC_URI', True)
        #bb.plain(src_uri)
        for i in range(len(cherrypicks_and_replace) / 2):
            patchname = "file://" + cherrypicks_and_replace[(i*2) + 1]
            #bb.plain("------> replacing %s"%(patchname))
            m = re.search("file://(\S+)\.patch\S*", patchname)
            patchname_base = m.group(1)
            newpatchname = "file://cherry_picked_" + cherrypicks_and_replace[(i*2) + 1]
            #bb.plain("------> replacing %s"%(patchname_base))
            # replace base patch
            src_uri = re.sub(r"file://"+patchname_base+".patch\S*", newpatchname, src_uri)
            # replace _usrxxx and .usrxxx suffix
            src_uri = re.sub(r"file://"+patchname_base+"[_\.]usr[\w\.]+\.patch\S*", newpatchname, src_uri)
            # replace -iii suffix
            src_uri = re.sub(r"file://"+patchname_base+"-\d+\.patch\S*", newpatchname, src_uri)

        #bb.plain(src_uri)
        d.setVar('SRC_URI',src_uri)
}
