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
	Private padel As CreateJSShape
End Sub

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 800, 700, "", CreateMap("border": "black solid 1px"))
	'prepare the stage, this raises game_ready
	game.Prepare
End Sub

Sub game_ready
	'build the game elements
	padel.Initialize
	padel.SetWidth(100)
	padel.graphics.BeginFill("#0000FF")
	padel.Graphics.drawRect(0, 0, padel.GetWidth, 20)
	padel.SetX(0)
	padel.SetNextX(0)
	padel.SetY(game.GetCanvasHeight - 20)
	game.addChild(padel.Shape)
	'start the game, this raises, game_update
	game.Start(60)
End Sub

'move padel
Sub game_keydown(e As BANanoEvent)
	Select Case e.KeyCode
		Case game.ARROW_KEY_LEFT
			leftKeyDown = True
		Case game.ARROW_KEY_RIGHT
			rightKeyDown = True
	End Select
End Sub

'stop padel
Sub game_keyup(e As BANanoEvent)
	Select Case e.KeyCode
		Case game.ARROW_KEY_LEFT
			leftKeyDown = False
		Case game.ARROW_KEY_RIGHT
			rightKeyDown = False
	End Select
End Sub

'each time a tick runs
Sub game_update
	'get the current position of the shape
	Dim nextX As Int = padel.GetX
	'the left key has been pressed
	If leftKeyDown Then
		nextX = padel.GetX - 10
		'ensure we dont over-run the stage
		If nextX < 0 Then
			nextX = 0
		End If
	else if rightKeyDown Then
		'if right is pressed, we get the current position
		'increment it by 10 and set it as the next position
		nextX = padel.GetX + 10
		'get the canvas width and ensure that the nextpos is within stage
		If (nextX > game.GetCanvasWidth - padel.GetWidth) Then
			nextX = game.GetCanvasWidth - padel.GetWidth
		End If
	End If
	'set the next position
	padel.SetNextX(nextX)
	'move the paddle to the next position
	padel.SetX(padel.GetNextX)
	'execute the stage update
	game.update
End Sub
