B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private game As BANanoCreateJS
	Private BANano As BANano  'ignore
	Private index As Int
	Private colors As List
	Private drawingCanvas As CreateJSShape
	Private oldPt As BANanoObject
	Private oldMidPt As BANanoObject
	Private color As String
	Private stroke As Object
	Private title As CreateJSText
End Sub

'paint application

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	colors.Add("#828b20")
	colors.Add("#b0ac31")
	colors.Add("#cbc53d")
	colors.Add("#fad779")
	colors.Add("#f9e4ad")
	colors.Add("#faf2db")
	colors.Add("#563512")
	colors.Add("#9b4a0b")
	colors.Add("#d36600")
	colors.Add("#fe8a00")
	colors.Add("#f9a71f")
	'
	game.autoClear(False)
	game.enableDOMEvents(True)
	game.TouchEnable
	game.SetFPS(24)
	
	drawingCanvas.Initialize
	Dim e As BANanoEvent
	game.OnMouseDown(BANano.CallBack(Me, "handlemousedown", Array(e)))
	game.OnMouseUp(BANano.CallBack(Me, "handleMouseUp", Array(e)))
	'
	title.Initialize("Click and Drag to draw", "36px Arial", "#777777")
	title.setx(300)
	title.sety(200)
	game.addChild(title.text)
	'
	game.addChild(drawingCanvas.Shape)
	game.update
End Sub

Sub handleMouseDown(e As BANanoEvent)
	Log(e)
	If game.contains(title.text) Then
		game.Clear
		game.RemoveChild(title.text)
	End If
	index = index + 1
	Dim modit As Int = index Mod colors.Size
	color = colors.Get(modit)
	stroke = game.Math_round(game.Math_random() * 30 + 10)
	oldPt = game.newpoint(game.GetMouseX, game.GetMouseY)
	oldMidPt = oldPt
	Dim e As BANanoEvent
	game.OnMouseMove(BANano.CallBack(Me, "handleMouseMove", Array(e)))
End Sub

Sub handleMouseMove(e As BANanoEvent)
	Dim oldPt1 As CreateJSPoint = game.GetPoint(oldPt)
	Dim oldMidPt1 As CreateJSPoint = game.GetPoint(oldMidPt)
	'
	Dim midPt As BANanoObject
	Dim mx As Object = game.getmouseX
	Dim x1 As Object = BANano.Eval(mx >> 1)
	Dim my As Object = game.getmouseY
	Dim y1 As Object = BANano.Eval(my >> 1)
	midPt = game.NewPoint(oldPt1.x + x1, oldPt1.y + y1)
	Dim midPt1 As CreateJSPoint = game.GetPoint(midPt)
	
	drawingCanvas.graphics.clear()
	drawingCanvas.graphics.setStrokeStyle3(stroke, "round", "round")
	drawingCanvas.graphics.beginStroke(color)
	drawingCanvas.graphics.moveTo(midPt1.x, midPt1.y)
	drawingCanvas.graphics.curveTo(oldPt1.x, oldPt1.y, oldMidPt1.x, oldMidPt1.y)
	oldPt1.x = game.getmouseX
	oldPt1.y = game.getmouseY
	oldMidPt1.x = midPt1.x
	oldMidPt1.y = midPt1.y
	'create points
	oldPt = game.NewPoint(oldPt1.x, oldPt1.y)
	oldMidPt = game.NewPoint(oldMidPt1.x, oldMidPt1.y)
	game.update
End Sub

Sub handleMouseUp(e As BANanoEvent)
	game.RemoveEventListener("stagemousemove", BANano.CallBack(Me, "handleMouseMove", Array(e)))
End Sub

Sub game_update
	game.update
End Sub