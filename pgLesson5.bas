B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private game As BANanoCreateJS
	Private BANano As BANano  'ignore
End Sub

'we apply easing to the animation, using Tween_To3

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 600, 600, "", CreateMap())
	'add resources to the manifest for the game
	game.AddManifest("butterfly", "./assets/butterfly.png")
	game.AddManifest("woosh", "./assets/woosh.mp3")
	game.AddManifest("chime", "./assets/chime.mp3")
	'start the game at 60 frames per second
	game.Start(60)
End Sub

Sub game_ready
	'get the image from loaded resources
	Dim img As BANanoObject = game.getManifest("butterfly")
	Dim i As Int
	Dim sound As BANanoObject
	Dim bf As BANanoObject
		
	For i = 0 To 2
		'create the bitmap
		bf = game.NewBmp(img)
		'set the position
		game.SetX(bf, i * 200)
		'add child to stage
		game.AddChild(bf)
		'get the target to tween
		game.Tween_Get(bf,False)
		'wait for some time
		game.Tween_Wait(i * 1000)
		'move to using a tween
		game.Tween_To3(CreateMap("y":100), 1000, game.Ease_QuadOut)
		'when done, fire butterflycomplete
		game.Tween_Call(BANano.CallBack(Me, "butterflycomplete", Array(bf)))
		'play the sound
		sound = game.Sound_Play3("woosh", game.Sound_Interupt_None, i * 1000)
	Next
End Sub

Sub butterflyComplete(displayObject As BANanoObject)
	'remove the butterfly
	game.RemoveChild(displayObject)
	Dim nc As Long = game.GetNumChildren
	If nc <> 0 Then
		game.Sound_Play1("chime")
	End If
End Sub

Sub game_update
	'refresh the stage each time the tick fires
	game.update
End Sub