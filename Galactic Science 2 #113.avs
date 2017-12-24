Import("D:\dxtory\galacticscience2\common.avs")
video=Import("D:\dxtory\galacticscience2\galacticscience2-0150.avi.avs")
MakeVideo(video, "Episode 113\n Sword of the Wyvern \n  and Testing of It\n  ", "Galactic Science 2 #113.png")
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

