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
	Private circle As CreateJSShape
End Sub

'bounceout

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	'create a circle within a parent game
	circle.Initialize2(game)
	'fill color red
	circle.graphics.beginFill("red")
	'x = 0, y = 0, radius = 50
	circle.graphics.drawCircle(0, 0, 50)
	'set the x & y
	circle.setx(100)
	circle.sety(-50)
	circle.Add
	'
	'tween the ball from -50 to 300 within 1500 millisends and bounceOut
	circle.TweenGet(False)
	circle.TweenTo3(CreateMap("y":300), 1500, game.Ease_BounceOut)
	'
	circle.Refresh
	'start the game
	game.Start(60)
End Sub

Sub game_update
	game.update
End Sub