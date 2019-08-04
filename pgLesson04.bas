B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private game As BANanoCreateJS
	Private BANano As BANano  'ignore
	Private bf1 As BANanoObject
End Sub

'we apply easing to the animation, using Tween_To3

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 600, 600, "", CreateMap())
	'add resources to the manifest for the game
	game.AddManifest("butterfly", "./assets/butterfly.png")
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	'get the image from loaded resources
	Dim img As BANanoObject = game.getManifest("butterfly")
	'create a new bitmap
	bf1 = game.NewBmp(img)
	'add it to the stage
	game.AddChild(bf1)
	'update the stage
	game.update
	
	'get the object you want to animate, remove it, change position, redraw in new position
	'animation should run for 1 second
	game.Tween_Get(bf1,False)
	'wait for before you start animation
	game.Tween_Wait(2000)
	'change the properties you need
	Dim toPos As Map = CreateMap()
	'y should be current position + 100
	Dim y As Long = game.IncrementY(bf1,100)
	toPos.Put("y", y)
	'animation should be exactly 1 second
	game.Tween_To3(toPos, 1000, game.Ease_QuadOut)
	'start the game at 60 frames per second
	game.Start(60)
End Sub

Sub game_update
	'refresh the stage each time the tick fires
	game.update
End Sub