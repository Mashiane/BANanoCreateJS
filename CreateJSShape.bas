B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Shape As BANanoObject
	Public Graphics As CreateJSGraphics
	Type CreateJSPoint(x As Int, y As Int)
	Public stage As BANanoCreateJS
	Private tweenObject As BANanoObject
	Private createjs As BANanoObject
End Sub

Public Sub Initialize()
	'initialize the graphics
	Graphics.Initialize
	'initialize the shape
	Shape.Initialize2("createjs.Shape", Array(Graphics.Graphics))
	tweenObject = Null
	createjs = Null
End Sub

'cache (x, y, width, height, [scale=1])
Sub SetCache(x As Int, y As Int, width As Int, height As Int)
	Shape.RunMethod("cache", Array(x, y, width, height))
End Sub

Sub SetMask(msk As CreateJSShape)
	Shape.SetField("mask", msk.Shape)
End Sub

'setTransform([x=0] [y=0] [scaleX=1] [scaleY=1] [rotation=0] [skewX=0] [skewY=0] [regX=0] [regY=0])
Sub SetTransform4(x As Int, y As Int, scaleX As Double, scaleY As Double)
	Shape.RunMethod("setTransform", Array(x, y, scaleX, scaleY))
End Sub

'get the object to tween
Sub TweenGet(bLoop As Boolean)
	Dim opt As Map = CreateMap("loop": bLoop)
	tweenObject = createjs.GetField("Tween").RunMethod("get",Array(Shape,opt))
End Sub

'tween wait, the number of milliseconds to wait for the animation to start
Sub TweenWait(timeframe As Long)
	tweenObject.RunMethod("wait", Array(timeframe))
End Sub

'tween set properties
Sub TweenSet(props As Map)
	tweenObject.RunMethod("set", Array(props))
End Sub

'tween with easing
Sub TweenTo3(props As Map, duration As Int, easing As BANanoObject)
	tweenObject.RunMethod("to", Array(props, duration, easing))
End Sub

'tween with duration only
Sub TweenTo2(props As Map, duration As Int)
	tweenObject.RunMethod("to", Array(props, duration))
End Sub

'function to call when the animation completes
Sub TweenCall(bc As BANanoObject)
	tweenObject.RunMethod("call", Array(bc))
End Sub

'remove event listener
Sub RemoveEventListener(event As String, cb As BANanoObject)
	Shape.RunMethod("removeEventListener", Array(event, cb))
End Sub

'initialize from an existing shape
Sub Initialize1(shp As BANanoObject)
	Shape = shp
	'get the graphics
	Dim grp As BANanoObject = Shape.GetField("Graphics")
	Graphics.Initialize1(grp)
End Sub

'initialize a shape for the game
Sub Initialize2(gm As BANanoCreateJS)
	stage = gm
	createjs = stage.createjs
	'initialize the graphics
	Graphics.Initialize
	'initialize the shape
	Shape.Initialize2("createjs.Shape", Array(Graphics.Graphics))
End Sub

'add the shape to the game
Sub Add
	stage.AddChild(Shape)
End Sub

'remove from the game
Sub Remove
	stage.RemoveChild(Shape)
End Sub

'refresh to update the stage with the shape
Sub Refresh
	stage.update
End Sub

'get the local point for the shape
Sub GlobalToLocal(ix As Int, iy As Int) As BANanoObject
	Dim pt As BANanoObject = Shape.RunMethod("globalToLocal", Array(ix, iy))
	Return pt
End Sub

'get a hit test from a point
Sub GetHitTest(game As BANanoCreateJS) As Boolean
	Dim pt As CreateJSPoint = GetLocalPoint(game)
	Dim hitTest As Boolean = Shape.RunMethod("hitTest", Array(pt.x, pt.y))
	Return hitTest
End Sub

'get a hit test from a point
Sub GetHitTest1() As Boolean
	Dim pt As CreateJSPoint = GetLocalPoint1
	Dim hitTest As Boolean = Shape.RunMethod("hitTest", Array(pt.x, pt.y))
	Return hitTest
End Sub

'get local position from mouse
Sub GetLocalPoint1() As CreateJSPoint
	Return GetLocalPoint(stage)
End Sub

'get local position from mouse
Sub GetLocalPoint(game As BANanoCreateJS) As CreateJSPoint
	Dim pt As BANanoObject = GlobalToLocal(game.getMouseX, game.getMouseY)
	Dim x As Int = pt.GetField("x")
	Dim y As Int = pt.GetField("y")
	Dim pnt As CreateJSPoint
	pnt.Initialize
	pnt.x = x
	pnt.y = y 
	Return pnt
End Sub

Sub GetOffsetPoint(game As BANanoCreateJS, e As BANanoEvent) As CreateJSPoint
	Dim shp As CreateJSShape = game.GetEventShape(e)
	Dim gp As CreateJSPoint = game.GetStagePoint(e)
	Dim pt As CreateJSPoint
	pt.Initialize
	pt.x = shp.GetX - gp.x  
	pt.y = shp.GetY - gp.y
	Return pt
End Sub

Sub GetOffsetPoint1(e As BANanoEvent) As CreateJSPoint
	Return GetOffsetPoint(stage,e)
End Sub

'add an event for the shape
Sub AddEventListener(evnt As String, cb As BANanoObject)
	Shape.AddEventListener(evnt, cb, False)
End Sub

'update current Y by
Sub Add2Y(v As Long)
	'get last y
	Dim y As Long = GetY
	y = y + v
	SetY(y)
End Sub

'update current x by
Sub Add2X(v As Long)
	'get last x
	Dim x As Long = GetX
	x = x + v
	SetY(x)
End Sub

'update current Y by and return new value
Sub IncrementY(v As Long) As Long
	'get last y
	Dim y As Long = GetY
	y = y + v
	Return y
End Sub

'update current X by and return new value
Sub IncrementX(v As Long) As Long
	'get last x
	Dim x As Long = GetX
	x = x + v
	Return x
End Sub

'on click
Sub OnClick(cb As BANanoObject)
	Shape.AddEventListener("click", cb, False)
End Sub

'on double click
Sub OnDblClick(cb As BANanoObject)
	Shape.AddEventListener("dblclick", cb, False)
End Sub

'on mouse over
Sub OnMouseOver(cb As BANanoObject)
	Shape.AddEventListener("mouseover", cb, False)
End Sub

'on press move
Sub OnPressMove(cb As BANanoObject)
	Shape.AddEventListener("pressmove", cb, False)
End Sub

'on press up
Sub OnPressUp(cb As BANanoObject)
	Shape.AddEventListener("pressup", cb, False)
End Sub

'on press up
Sub OnRollUp(cb As BANanoObject)
	Shape.AddEventListener("rollup", cb, False)
End Sub

'on press up
Sub OnRollOver(cb As BANanoObject)
	Shape.AddEventListener("rollover", cb, False)
End Sub


'on mouse out
Sub OnMouseOut(cb As BANanoObject)
	Shape.AddEventListener("mouseout", cb, False)
End Sub

'on mouse down
Sub OnMouseDown(cb As BANanoObject)
	Shape.AddEventListener("mousedown", cb, False)
End Sub

'set homeX
Sub SetHomeX(x As String)
	Shape.SetField("homeX", x)
End Sub

'get stageX
Sub GetStageX() As Long
	Dim res As Long = Shape.GetField("stageX").result
	Return res
End Sub

'get stageY
Sub GetStageY() As Long
	Dim res As Long = Shape.GetField("stageY").result
	Return res
End Sub

'get homeX
Sub GetHomeX() As Long
	Dim res As Long = Shape.GetField("homeX").result
	Return res
End Sub

'set homeY
Sub SetHomeY(y As String)
	Shape.SetField("homeY", y)
End Sub

'get homeY
Sub GetHomeY() As Long
	Dim res As Long = Shape.GetField("homeY").result
	Return res
End Sub


'set key
Sub SetKey(k As String)
	Shape.SetField("key", k)	
End Sub

'get the key
Sub GetKey() As String
	Dim res As String = Shape.GetField("key").result
	Return res
End Sub

'set alpha
Sub SetAlpha(a As Double)
	Shape.SetField("alpha", a)
End Sub

'set the cursor to be a pointer
Sub SetCursorPointer
	Shape.SetField("cursor", "pointer")
End Sub

'set name
Sub SetName(n As String)
	Shape.SetField("name", n)
End Sub

'set x position
Sub SetX(x As Int)
	Shape.SetField("x", x)
End Sub	

'set y position
Sub SetY(y As Int)
	Shape.SetField("y", y)
End Sub

'set width position
Sub SetWidth(y As Int)
	Shape.SetField("width", y)
End Sub

'set height position
Sub SetHeight(y As Int)
	Shape.SetField("height", y)
End Sub

'get x position
Sub GetX() As Long
	Dim res As Long = Shape.GetField("x").result
	Return res
End Sub

'get y position
Sub GetY() As Long
	Dim res As Long = Shape.GetField("y").result
	Return res
End Sub

'get width
Sub GetWidth() As Long
	Dim res As Long = Shape.GetField("width").result
	Return res
End Sub

'get height
Sub GetHeight() As Long
	Dim res As Long = Shape.GetField("height").result
	Return res
End Sub

'get nextY position
Sub GetNextY() As Long
	Dim res As Long = Shape.GetField("nextY").result
	Return res
End Sub

'get nextX position
Sub GetNextX() As Long
	Dim res As Long = Shape.GetField("nextX").result
	Return res
End Sub

'get radius
Sub GetRadius() As Long
	Dim res As Long = Shape.GetField("radius").result
	Return res
End Sub

'set radius
Sub SetRadius(r As Long)
	Shape.SetField("radius", r)
End Sub

'set scale X position
Sub SetScaleX(x As Int)
	Shape.SetField("scaleX", x)
End Sub

'set scale y position
Sub SetScaleY(y As Int)
	Shape.SetField("scaleY", y)
End Sub

'set skew X position
Sub SetSkewX(x As Int)
	Shape.SetField("skewX", x)
End Sub

'set skew y position
Sub SetSkewY(y As Int)
	Shape.SetField("skewY", y)
End Sub

'set rotation
Sub SetRotation(y As Int)
	Shape.SetField("rotation", y)
End Sub

Sub regX(x As Int)
	Shape.SetField("regX", x)
End Sub

Sub regY(x As Int)
	Shape.SetField("regY", x)
End Sub

'set regX position
Sub SetRegX(x As Int)
	Shape.SetField("regX", x)
End Sub	

'set y position
Sub SetRegY(y As Int)
	Shape.SetField("regY", y)
End Sub

'set nextX position
Sub SetNextX(x As Int)
	Shape.SetField("nextX", x)
End Sub	

'set nextY position
Sub SetNextY(y As Int)
	Shape.SetField("nextY", y)
End Sub

'set txt position
Sub SetTxt(txt As BANanoObject)
	Shape.SetField("txt", txt)
End Sub

'get the txt content
Sub GetTxt As BANanoObject
	Dim bo As BANanoObject = Shape.GetField("txt")
	Return bo
End Sub
