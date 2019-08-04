B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public ID As String
	Public frames As List
	Public NextAnimation As String
	Public Speed As Double
	Public StartFrame As Int
	Public EndFrame As Int
End Sub

'simple animation
Sub Simple As List
	Dim itm As List
	itm.Initialize 
	'start, end, next, speed
	If StartFrame <> -1 Then itm.Add(StartFrame)
	If EndFrame <> -1 Then itm.Add(EndFrame)
	If NextAnimation <> "" Then itm.Add(NextAnimation)
	If Speed <> -1 Then itm.Add(Speed)
	Return itm
End Sub

'complex animation
Sub Complex As Map
	Dim opt As Map = CreateMap()
	opt.Put("frames", frames)
	If NextAnimation <> "" Then opt.Put("next", NextAnimation)
	If Speed <> -1 Then opt.Put("speed", Speed)
	Return opt
End Sub

'Initializes the 
Public Sub Initialize(aID As String) As CreateJSAnimation
	ID = aID.tolowercase
	frames.Initialize 
	NextAnimation = ""
	Speed = -1
	StartFrame = -1
	EndFrame = -1
	Return Me
End Sub

'set next animation
Sub SetNextAnimation(na As String) As CreateJSAnimation
	NextAnimation = na
	Return Me
End Sub

'set speed
Sub SetSpeed(spd As Double) As CreateJSAnimation
	Speed = spd
	Return Me
End Sub

'add a single frames
Sub AddFrame(frm As Int) As CreateJSAnimation
	frames.Add(frm)
	Return Me
End Sub

'add frames
Sub AddFrames(frms As List) As CreateJSAnimation
	frames.AddAll(frms)
	Return Me
End Sub

'set start frame
Sub SetStart(start As Int) As CreateJSAnimation
	StartFrame = start
	Return Me
End Sub

'set end frame
Sub SetEnd(ednFrame As Int) As CreateJSAnimation
	EndFrame = ednFrame
	Return Me
End Sub