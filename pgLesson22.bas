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
	Private leftKeyDown As Boolean = False
	Private rightKeyDown As Boolean = False
End Sub

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 800, 700, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	'build the game elements
	
	'start the game
	game.Start(60)
End Sub

Sub game_keydown(e As BANanoEvent)
	Select Case e.KeyCode
		Case game.ARROW_KEY_LEFT
			Log("move left")
		Case game.ARROW_KEY_UP
			Log("move up")
		Case game.ARROW_KEY_RIGHT
			Log("move right")
		Case game.ARROW_KEY_DOWN
			Log("move down")
	End Select
End Sub

Sub game_update
	game.update
End Sub