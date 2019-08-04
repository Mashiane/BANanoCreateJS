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
	game.Initialize(Me, "body", "canvas", 600, 600, "", CreateMap())
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Log("game_ready")
	'
	Dim square As CreateJSShape
	square.Initialize()
	square.Graphics.BeginStroke("#000")
	square.Graphics.BeginFill("#FF0000")
	square.Graphics.DrawRect(0,0,100,100)
	square.SetregX(50)  ' half of the width being a center
	square.SetregY(50)  ' half of the height being a center
	square.Setx(game.GetCanvasWidth / 2)
	square.Sety(game.GetCanvasheight / 2)
	game.AddShape(square)
	'rotate the square
	game.Tween_Get(square.shape,True)
	game.Tween_To2(CreateMap("rotation":360),2000)
	'
	Dim rectangle As CreateJSShape
	rectangle.Initialize()
	rectangle.Graphics.beginStroke("#000")
	rectangle.Graphics.beginFill("#FF0000")
	rectangle.Graphics.drawRect(0, 0, 150, 100)
	rectangle.SetX(30)
	rectangle.Sety(20)
	game.AddShape(rectangle)
	'
	Dim circle As CreateJSShape
	circle.Initialize
	circle.Graphics.beginStroke("#000")
	circle.Graphics.beginFill("#FFF000")
	circle.Graphics.drawCircle(0, 0, 50)
	circle.Setx(300)
	circle.Sety(70)
	game.AddShape(circle)
	'
	Dim poly As CreateJSShape
	poly.Initialize
	poly.Graphics.beginStroke("#000")
	poly.Graphics.beginFill("#90ABC2")
	poly.Graphics.drawPolyStar(0, 0, 60, 6, 0.6)
	poly.Setx(450)
	poly.Sety(70)
	game.AddShape(poly)
	'
	Dim tri As CreateJSShape
	tri.Initialize 
	tri.Graphics.beginStroke("#000")
	tri.Graphics.beginFill("#00FF00")
	tri.Graphics.moveTo(50, 0)
	tri.Graphics.lineTo(0, 100)
	tri.Graphics.lineTo(100, 100)
	tri.Graphics.lineTo(50, 0)
	tri.Setx(20)
	tri.Sety(150)
	game.addShape(tri)
	'
	'Dim roundedRectangle As CreateJSShape
	'roundedRectangle.graphics.beginStroke("#000")
	'roundedRectangle.graphics.beginFill("pink")
	'roundedRectangle.graphics.drawRoundRect(0,0,400,100,10)
	'roundedRectangle.Setx(150)
	'roundedRectangle.Sety(150)
	'game.AddShape(roundedRectangle)
	'start the game at 60 frames per second
	game.Start(60)
End Sub

Sub game_update
	game.update
End Sub