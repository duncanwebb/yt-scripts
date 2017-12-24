Import("D:\dxtory\galacticscience2\common.avs")
video1=Import("D:\dxtory\galacticscience2\galacticscience2-0155.avi.avs")
video2=Import("D:\dxtory\galacticscience2\galacticscience2-0156.avi.avs")
video=video1++video2
intro=Import("D:\dxtory\galacticscience2\galacticscience2-0156.avi.avs").Trim(270, 270+359).Crop(0, 0, Width-300, Height).AddBorders(300, 0, 0, 0).KillAudio()
MakeVideo(video, "Episode 117\n Neodymium Episode &\n  a trip to Callisto\n  ", intro=intro)
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

