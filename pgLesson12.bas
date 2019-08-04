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
	Private offSet As CreateJSPoint
End Sub

'drag a shape

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Dim e As BANanoEvent
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
	
	'add mouse down event to circle
	circle.OnMouseDown(BANano.CallBack(Me, "circle_mousedown", Array(e)))
End Sub

'fire when clicked
Sub circle_mousedown(e As BANanoEvent)
	'get the shape from the event
	Dim circleShape As CreateJSShape = game.GetEventShape(e)
	Dim stagePoint As CreateJSPoint = game.GetStagePoint(e)
	'
	offSet.Initialize 
	offSet.x = circleShape.GetX - stagePoint.x
	offSet.y = circleShape.GetY - stagePoint.y
	'
	circle.OnPressMove(BANano.CallBack(Me,"circle_pressmove",Array(e)))
End Sub

Sub circle_pressmove(e As BANanoEvent)
	Dim circleShape As CreateJSShape = game.GetEventShape(e)
	Dim stagePoint As CreateJSPoint = game.GetStagePoint(e)
	'
	circleShape.SetX(stagePoint.x + offSet.x)
	circleShape.SetY(stagePoint.Y + offSet.y)
	
	game.update
	
End Sub
