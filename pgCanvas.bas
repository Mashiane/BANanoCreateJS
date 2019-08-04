B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private game As UOECanvasGames
	Private butterfly As BANanoObject
End Sub

Sub Init
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
End Sub

Sub game_ready
	Log("game_ready")
	'create a new image
	butterfly = game.NewBmp("./assets/butterfly.png")
End Sub

'a new image has been added to the game
Sub new_image(bmp As BANanoObject)
	'Log("new_image")
	'Log(bmp)
	'butterfly = bmp
	'game.DrawImage(bmp, 0, 0, 200, 138, 0, 0, 200, 138)
	'game.DrawImage(bmp, 0, 0, 200, 138, 200, 0, 200, 138)
	'game.DrawImage(bmp, 0, 0, 200, 138, 400, 0, 200, 138)
End Sub