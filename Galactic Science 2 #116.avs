Import("D:\dxtory\galacticscience2\common.avs")
video1=Import("D:\dxtory\galacticscience2\galacticscience2-0153.avi.avs")
video2=Import("D:\dxtory\galacticscience2\galacticscience2-0154.avi.avs")
video=video1++video2
MakeVideo(video, "Episode 116\n Lego Man, \n  a Trip to Elpis \n  & More Scrap", "Galactic Science 2 #116.png")
return last

video=video1++video2
video=Dissolve(video1, video2, joinduration)
video=TransMarbles(video1, video2, joinduration, marbleradius, drop=false)

log = "D:\dxtory\galacticscience2\chapters01.txt"
Exist(log) ? NOP : Eval("""
len=video1.FrameCount()-joinduration
WriteFile(log, String(len), append=false)
len=len+video2.FrameCount()-joinduration
WriteFile(log, String(len), append=true)
len=len+video3.FrameCount()-joinduration
WriteFile(log, String(len), append=true)
len=len+video4.FrameCount()-joinduration
WriteFile(log, String(len), append=true)
len=len+video5.FrameCount()-joinduration
WriteFile(log, String(len), append=true)
""") 
return last

