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

'move a shape via click event

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Dim e As BANanoEvent
	game.OnMouseUp(BANano.CallBack(Me,"game_mouseup",Array(e)))
	'create a circle within a parent game
	circle.Initialize2(game)
	'fill color red
	circle.graphics.beginFill("red")
	'x = 0, y = 0, radius = 50
	circle.graphics.drawCircle(0, 0, 50)
	'set the x & y
	circle.setx(100)
	circle.sety(100)
	circle.Add
	game.Update
	
	'add click event to circle
	circle.OnClick(BANano.CallBack(Me, "circle_click", Array(e)))
End Sub

'fire when clicked
Sub circle_click(e As BANanoEvent)
	Log(e)
	Log("circle_click")
	'get the shape from the event
	Dim clickedShape As CreateJSShape = game.GetEventShape(e)
	'get the x position
	Dim x As Int = clickedShape.GetX
	x = x + 10
	clickedShape.SetX(X)
	game.update
End Sub

Sub game_mouseup(e As BANanoEvent)
	'get the stage point, this returns x & y
	Dim pt As CreateJSPoint = game.GetStagePoint(e)
	'set the circle points
	circle.SetX(pt.x)
	circle.SetY(pt.y)
	game.update
End Sub