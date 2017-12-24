LoadPlugin("C:\Program Files (x86)\MeGUI\tools\avisynth_plugin\NicAudio.dll")

global s2 = "Until next time..."
global testcard = "D:\dxtory\galacticscience2\testcard.jpg"
global introverlay = "D:\dxtory\galacticscience2\galacticscience2.png"
global outroimage = "D:\dxtory\galacticscience2\galacticscience2base.png"
global introaudio = "D:\dxtory\galacticscience2\spooky.mp3"
global outroaudio = "D:\dxtory\The_Owl_-_02_-_owls_secret.mp3"
#global mechlsd = ImageSource("D:\dxtory\galacticscience2\mechlsd.png", pixel_type="RGB32", 0, 179)
global joinduration=60
global marbleradius=12


function MakeVideo(clip c, string title, string "screenshot", clip "intro", int "trim_in", int "trim_out")
{
    sx = 460
    sx = 70
    sx = 200
    sy = 574
    sy = 460
    sy = 600
    sy = 540
    font="Copasetic NF"
    font="Gin Rai"
    font="Gin Rai Italic"
    font_size=45
    text_color = $d6d6c8 #light gray
    halo_color = $ecb03c #light orange
    halo_color = $df8519 #dark orange
    fadein_frames = 0
    fadeout_frames = 90
    align = 5
    title_frames = 240

    trim_in = Default(trim_in, 0)
    trim_out = Default(trim_out, c.FrameCount())
    base = c.Trim(trim_in, trim_out)

    introimage = Default(screenshot, testcard)
    introvideo = Default(intro, "")

    name = ScriptName()
    introverlay = ImageSource(introverlay, pixel_type="RGB32", fps=30, 0, 239).Lanczos4Resize(1280, 720)
    introvideo = IsClip(intro) ? Eval("""
    intro.info()
	 return Trim(intro, 0, 239).Lanczos4Resize(1280, 720).ConvertToRGB32()
	 """) : Eval("""
	 return ImageSource(introimage, pixel_type="RGB32", fps=30, 0, 239).Lanczos4Resize(1280, 720)
	 """)
	 
    introclip = Overlay(introvideo, introverlay, mask=introverlay.ShowAlpha().FadeOut(fadein_frames), mode="blend", opacity=1)
    introaudio = NicMPG123Source(introaudio).AudioTrim(0, 20).FadeOut(150)
    intro = AudioDub(introclip, introaudio)
    av1 = Subtitle(intro, title, sx, sy, font=font, size=font_size, text_color=text_color, halo_color=halo_color, lsp=-80)

    outrovideo = ImageSource(outroimage, pixel_type="RGB32", fps=30, 0, 599).Lanczos4Resize(1280, 720).FadeIn(fadein_frames)
    outroaudio = NicMPG123Source(outroaudio).AudioTrim(0, 20).FadeOut(150)
    outro = AudioDub(outrovideo, outroaudio)
    
    #return Info(c)
    Dissolve(av1, c.ConvertToRGB32, 10)

    #Overlay(base, pngclip, mask=pngclip.ShowAlpha().FadeOut(fadein_frames), mode="blend", opacity=0.9)
    #Overlay(last, intro, mask=intro.ShowAlpha().FadeOut(fadein_frames), 0, 0) 
    ##Overlay(last, intro, mask=intro.ShowAlpha().FadeIO(fadein_frames), 0, 0) 

    FadeOut(fadeout_frames)
    Subtitle(s2, first_frame=FrameCount-title_frames-1, last_frame=FrameCount-1, size=font_size, align=align, text_color=text_color, halo_color=halo_color, lsp=50)

    last++outro
    
    #v1 = last.Trim(50, 51)
    #ImageWriter(v1, "D:\dxtory\galacticscience2\"+imgname+"-", 0, 0, "png")
    
    ConvertToYV12(interlaced=false)
    #tweak(bright=10)

    return last
}

MakeVideo(BlankClip(width=1280, height=720, fps=30, length=300, channels=2), "This is a Test\n on three\n  lines", testcard)