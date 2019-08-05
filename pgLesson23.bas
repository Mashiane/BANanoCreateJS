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
End Sub

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 500, 500, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Dim txt As CreateJSText
	txt.Initialize("Game Over", "20px Arial", "#ff7700")
	txt.SetTextBaseline("middle")
	txt.SetTextAlign("center")
	txt.SetX(game.GetCanvasWidth/2)
	txt.SetY(game.GetCanvasHeight/2)
	game.addChild(txt.Text)
	game.Update
End Sub

Sub game_update
	game.update
End Sub