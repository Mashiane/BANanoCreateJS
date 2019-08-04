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
	Dim direction As Int = 1
	Dim speed As Int = 10
	Dim circle As CreateJSShape
End Sub

'Here you have a ball that bounces back And forth between the walls of the stage. In the update function, you first
'check what the location of the ball will be If you were To change its x position by factoring in the current speed And
'direction. You set this value To a temporary variable. If this value Is beyond the bounds of either side of the stage, you
'set that value so that it would set the ball directly against the wall in its path; in other words, it won’t let it extend past
'your boundaries. You Then assign your ball a variable that stores what its new location should be the Next time it’s
'rendered. The render function Is Then called, where you Then assign the new x position To the ball

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 700, 700, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	circle.Initialize 
	circle.graphics.beginStroke("#000")
	circle.graphics.beginFill("#FFF000")
	circle.graphics.drawCircle(0, 0, 50)
	circle.setradius(50)
	circle.setx(100)
	circle.sety(300)
	game.addshape(circle)
	'start the game at 60 frames per second
	game.Start(60)
End Sub

Sub game_update
	updateCircle
	renderCircle
	game.update
End Sub

Sub updateCircle
	'save the current position of X
	Dim nextX As Long = circle.GetX + (speed * direction)
	If nextX > (game.GetCanvasWidth - circle.GetRadius) Then
		nextX = game.GetCanvasWidth - circle.GetRadius
		direction = direction * -1
	else if (nextX < circle.GetRadius) Then
		nextX = circle.GetRadius
		direction = direction * -1
	End If
	circle.SetNextX(nextX)	
End Sub

Sub renderCircle
	'get next x
	Dim nextX As Int = circle.GetNextX
	circle.setx(nextX)
End Sub