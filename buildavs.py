import os, sys
from glob import *
from string import Template

s = Template("""source = "${source}"
LoadPlugin("C:\\Program Files (x86)\\MeGUI\\tools\\ffms\\ffms2.dll")
V = FFVideoSource(source, fpsnum=30, fpsden=1, threads=1).Lanczos4Resize(1280, 720)
A1 = FFAudioSource(source, track=1).AmplifyDB(10) #.Normalize(volume=1.0, show=false)
A2 = FFAudioSource(source, track=2).Normalize(volume=1.0, show=false)
commentary = MonoToStereo(A1, A1) #.AmplifyDB(1.5)
audio = MixAudio(commentary, A2, 0.9, 0.1)
AudioDub(V, audio)
return last
""")

cwd = os.getcwd()

for avifile in glob("*.avi"):
    avsfile = avifile + ".avs"
    if os.path.exists(avsfile):
        continue
    source = os.path.join(cwd, avifile)
    print source
    with open(avsfile, "w") as fh:
        print >>fh, s.substitute(source=source)

idxfile = os.path.join(cwd, "index.avs")
cmmfile = os.path.join(cwd, "common.avs")
counter = 0
listvideos = []
with open(idxfile, "w") as fh:
    print >>fh, "Import(\"%s\")" % cmmfile
    for avsfile in glob("*.avi.avs"):
        counter += 1
        source = os.path.join(cwd, avsfile)
        video = "video%d" % counter
        listvideos.append(video)
        print >>fh, "Import(\"%s\")" % source
        print >>fh, "%s = last" % video
    print >>fh, "BlankClip(pixel_type=\"YV12\", width=480, height=360).Loop"
    sys.exit(0)
    count = len(listvideos)
    for i in range(0, count, 10):
        if i < count-10:
            print >>fh, "++".join(listvideos[i:i+10])+"++\\"
        else:
            print >>fh, "++".join(listvideos[i:count])
