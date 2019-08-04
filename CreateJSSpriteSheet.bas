B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private Images As List
	Public ID As String
	Private animations As Map
	Private frames As Map
	Public SpriteSheet As BANanoObject
	Private frameRate As Int	
End Sub

'add animation
Sub AddSimpleAnimation(aniID As String, aniStart As Int, aniEnd As Int, aniNext As String, aniSpeed As Double) As CreateJSSpriteSheet
	Dim anime As CreateJSAnimation
	anime.Initialize(aniID)
	anime.SetStart(aniStart)
	anime.SetEnd(aniEnd)
	anime.SetNextAnimation(aniNext)
	anime.SetSpeed(aniSpeed)
	animations.Put(aniID, anime.Simple)
	Return Me 	
End Sub

'build the spritesheet
Sub BuildSpriteSheet
	Dim data As Map = CreateMap()
	If frameRate <> 0 Then data.Put("framerate", frameRate)
	data.Put("images", Images)
	data.Put("animations", animations)
	data.Put("frames", frames)
	SpriteSheet.Initialize2("createjs.SpriteSheet", Array(data))
End Sub

'set the height of each frame
Sub SetFrameRate(h As Int) As CreateJSSpriteSheet
	frameRate = h
	Return Me
End Sub


'set the height of each frame
Sub SetHeight(h As Int) As CreateJSSpriteSheet
	frames.Put("height", h)
	Return Me
End Sub

'set the width of each frame
Sub SetWidth(w As Int) As CreateJSSpriteSheet
	frames.Put("width", w)
	Return Me
End Sub

'set the regx of each frame
Sub SetRegX(w As Int) As CreateJSSpriteSheet
	frames.Put("regX", w)
	Return Me
End Sub

'set the regy of each frame
Sub SetRegY(w As Int) As CreateJSSpriteSheet
	frames.Put("regY", w)
	Return Me
End Sub

'set the count of the frames
Sub SetCount(w As Int) As CreateJSSpriteSheet
	frames.Put("count", w)
	Return Me
End Sub

'Initializes the spritesheet
Public Sub Initialize(sID As String) As CreateJSSpriteSheet
	ID = sID.ToLowerCase
	Images.Initialize 
	animations.Initialize
	frameRate = 0
	Return Me
End Sub

'add sprite image
Sub AddImage(imgURL As String) As CreateJSSpriteSheet
	Images.Add(imgURL)
	Return Me
End Sub

'add a complex animation
Sub AddComplexAnimation(anime As CreateJSAnimation) As CreateJSSpriteSheet
	Dim aniID As String = anime.ID
	animations.Put(aniID, anime.Complex)
	Return Me
End Sub