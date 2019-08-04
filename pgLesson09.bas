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

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 400, 400, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	game.EnableMouseOver
	circle.Initialize
	circle.graphics.beginFill("#0000FF")
	circle.graphics.drawCircle(0, 0, 50)
	circle.setx(game.getcanvaswidth / 2)
	circle.sety(game.getcanvasheight / 2)
	circle.setname("Blue Circle")
	circle.SetCursorPointer
	game.addChild(circle.shape)
	game.update
	'
	Dim e As BANanoEvent
	circle.addEventListener("dblclick", BANano.CallBack(Me, "circle_dblclick", Array(e)))   ' can use .OnDblClick
	circle.addEventListener("mouseover", BANano.CallBack(Me, "circle_mouseover", Array(e)))  ' can use .OnMouseOver
	circle.addEventListener("mouseout", BANano.CallBack(Me, "circle_mouseout", Array(e)))    ' can use .OnMouseOut
	'
	'drag and drop
	'circle.OnMouseDown(BANano.CallBack(Me,"circle_mousedown",Array(e)))
	
	'start the game at 60 frames per second
	game.Start(60)
End Sub

'define drag and drop
Sub circle_mousedown(e As BANanoEvent)
	Log("circle_mousedown")
	'trap events on the stage
	'game.addEventListener("stagemousemove", BANano.CallBack(Me, "game_mousemove", Array(e)))
	'game.addEventListener("stagemouseup", BANano.CallBack(Me, "game_mouseup", Array(e)))
End Sub

Sub game_mouseup(e As BANanoEvent)
	Log("game_mouseup")
	Log(e) 
End Sub

'for drag and drop
Sub game_mousemove(e As BANanoEvent)
	Log("game_mousemove")
	circle.setx(game.getmouseX)
	circle.sety(game.getmouseY)
End Sub

Sub circle_mouseout(e As BANanoEvent)
	Log("mouseout")
	circle.setalpha(1)
End Sub

Sub circle_mouseover(e As BANanoEvent)
	Log("mouseover")
	circle.Setalpha(0.5)
End Sub

Sub circle_dblclick(e As BANanoEvent)
	Log("dblclick")
End Sub

Sub game_update
	game.update
End Sub