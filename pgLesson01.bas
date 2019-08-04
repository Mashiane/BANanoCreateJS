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
	Private bf2 As BANanoObject
	Private bf3 As BANanoObject
End Sub

Sub Init
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'add resources to the manifest for the game
	game.AddManifest("butterfly", "./assets/butterfly.png")
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	'the game is ready, lets create the objects to play with
	Log("game_ready")
	'get resource from manifest
	Dim img As BANanoObject = game.getManifest("butterfly")
	'add 3 images to the canvas
	bf1 = game.NewBmp(img)
	bf2 = game.NewBmp(img)
	bf3 = game.NewBmp(img)
	'set the locations
	game.SetX(bf2, 200)
	game.SetX(bf3, 400)
	'add the images to the stage
	game.AddChildren(Array(bf1,bf2,bf3))
	'update the game to ensure our objects are showing
	game.Update
	'after 1 second, move the butterfly
	BANano.Window.SetTimeout(BANano.CallBack(Me, "movebutterfly", Null), 1000)
	'start the game at 60 frames per second
	game.Start(60)
End Sub

Sub moveButterFly
	'get the last position of butterfly Y pos
	Dim bf2Y As Long = game.GetY(bf2)
	'increment it by 200
	bf2Y = bf2Y + 200
	'set the new position
	game.SetY(bf2,bf2Y)
	'update the game
	game.update
End Sub

Sub game_update
	Log("game_update")
End Sub