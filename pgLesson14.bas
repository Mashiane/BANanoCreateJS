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
	Private angle As Double
End Sub

'tranform images

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	angle = 0
	'create a circle within a parent game
	circle.Initialize2(game)
	'fill color red
	circle.graphics.beginFill("red")
	'x = 0, y = 0, radius = 50
	circle.graphics.drawCircle(0, 0, 50)
	'set the x & y
	circle.setx(200)
	circle.sety(300)
	circle.Add
	'
	game.update
	'start the game
	game.Start(60)
End Sub

Sub game_update
	angle = angle + 0.025
	Dim scale As Double = game.Math_cos(angle)
	circle.SetTransform4(circle.Getx, circle.gety, scale, scale)
	'this is the same as the two lines below as only the scalex and scaley are being changed
	'circle.SetScaleX(scale)
	'circle.SetScaleY(scale)
	game.update
End Sub