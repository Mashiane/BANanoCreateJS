B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public stage As BANanoObject
	Public queue As BANanoObject
	Public sound As BANanoObject
	Public createjs As BANanoObject
	Private manifests As List
	Public ID As String
	Private BANano As BANano 'ignore
	Private owner As Object
	Private FPS As Int
	Private tweenObject As BANanoObject
	Private ticker As BANanoObject
	Private touch As BANanoObject
	Private canvas As BANanoObject
	Private math As BANanoObject
	Public CONST ARROW_KEY_LEFT As Int = 37
	Public const ARROW_KEY_UP As Int = 38
	Public const ARROW_KEY_RIGHT As Int = 39
	Public const ARROW_KEY_DOWN As Int = 40
End Sub

'initialize the game, create the canvas on the container
'specify the width and height and classes to add / styles to apply
Public Sub Initialize(Module As Object, container As String, gid As String, Width As Int, Height As Int, classes As String, styles As Map)
	Dim el As BANanoElement
	ID = gid.tolowercase
	container = container.tolowercase
	'initialize the manifest
	manifests.Initialize
	'lets clear the container
	el = BANano.GetElement($"#${container}"$)
	'empty the container
	el.Empty
	'add a canvas
	Dim cvas As UOENowHTML
	cvas.Initialize(gid,"canvas")
	cvas.SetWidth(Width)
	cvas.SetHeight(Height)
	cvas.AddClass(classes)
	'add the styles to the canvas
	For Each strKey As String In styles.Keys
		Dim strVal As String = styles.Get(strKey)
		cvas.SetStyle(strKey,strVal)
	Next
	'add to the body
	el.Append(cvas.HTML)
	'
	owner = Module
	tweenObject = Null
	math.Initialize("Math")
	'add keydown event for window
	Dim e As BANanoEvent
	Dim bc As BANanoEvent = BANano.CallBack(owner, "game_keydown", Array(e))
	BANano.Window.addEventListener("keydown",bc, True)
	'add keyup event for window
	Dim e As BANanoEvent
	Dim bc As BANanoEvent = BANano.CallBack(owner, "game_keyup", Array(e))
	BANano.Window.addEventListener("keyup",bc, True)
End Sub

'get local point
Sub GetLocalPoint(shape As CreateJSShape) As CreateJSPoint
	Dim pt As BANanoObject = shape.globalToLocal(GetMouseX, GetMouseY)
	Dim x As Int = pt.GetField("x")
	Dim y As Int = pt.GetField("y")
	Dim pnt As CreateJSPoint
	pnt.Initialize 
	pnt.x = x
	pnt.y = y
	Return pnt
End Sub

Sub NewBlurFilter(a As Object, b As Object, c As Object) As BANanoObject
	Dim bf As BANanoObject
	bf.Initialize2("createjs.BlurFilter", Array(a,b,c))
	Return bf
End Sub

'get stage point
Sub GetStagePoint(e As BANanoEvent) As CreateJSPoint
	Dim stageX As Object = GetEventField(e, "stageX")
	Dim stageY As Object = GetEventField(e, "stageY")
	Dim pt As CreateJSPoint
	pt.Initialize
	pt.x = stageX
	pt.y = stageY
	Return pt
End Sub

'get point from bananoobject
Sub GetPoint(e As BANanoObject) As CreateJSPoint
	Dim stageX As Object = e.GetField("x")
	Dim stageY As Object = e.GetField("y")
	Dim pt As CreateJSPoint
	pt.Initialize
	pt.x = stageX
	pt.y = stageY
	Return pt
End Sub

'new point
Sub NewPoint(x As Int, y As Int) As BANanoObject
	Dim res As BANanoObject 
	res.Initialize2("createjs.Point", Array(x,y))
	Return res
End Sub

'get stagex
Sub GetStageX(e As BANanoEvent) As Int
	Dim stageX As Object = GetEventField(e, "stageX")
	Return stageX
End Sub

'get stageY
Sub GetStageY(e As BANanoEvent) As Int
	Dim stageY As Object = GetEventField(e, "stageY")
	Return stageY
End Sub

'when a keyboard is pressed
Sub OnKeyDown(bc As BANanoObject)
	BANano.Window.addEventListener("keydown",bc, True)
End Sub

'get event target
Sub GetEventTarget(e As BANanoEvent) As BANanoObject
	Dim res As BANanoObject = e.OtherField("target")
	Return res
End Sub

Sub GetChildByName(n As String) As BANanoObject
	Dim bo As BANanoObject = stage.RunMethod("getChildByName", Array(n))
	Return bo
End Sub

'get shape from event
Sub GetEventShape(e As BANanoEvent) As CreateJSShape
	Dim res As BANanoObject = GetEventTarget(e)
	Dim shp As CreateJSShape
	shp.Initialize1(res)
	Return shp 
End Sub

'get event field
Sub GetEventField(e As BANanoEvent, sField As String) As Object
	Dim res As Object = e.OtherField(sField)
	Return res
End Sub

'Math.random() 
Sub Math_Random() As Int
	Dim res As Int = math.RunMethod("random", Null).Result
	Return res
End Sub

'Math.round() 
Sub Math_Round(rValue As Object) As Int
	Dim res As Int = math.RunMethod("round", Array(rValue)).Result
	Return res
End Sub

'math.floor
Sub Math_Floor(proc As Int) As Int
	Dim res As Int = math.RunMethod("floor", Array(proc)).result
	Return res
End Sub

'match.cos
Sub Math_Cos(proc As Double) As Double
	Dim res As Int = math.RunMethod("cos", Array(proc)).result
	Return res
End Sub

'add an event for the stage
Sub addEventListener(evnt As String, cb As BANanoObject)
	stage.AddEventListener(evnt, cb, False)
End Sub

'on mouse move
Sub OnMouseMove(cb As BANanoObject)
	stage.AddEventListener("stagemousemove", cb, False)
End Sub

'on click
Sub OnClick(cb As BANanoObject)
	stage.AddEventListener("click", cb, False)
End Sub

'on mouse up
Sub OnMouseUp(cb As BANanoObject)
	stage.AddEventListener("stagemouseup", cb, False)
End Sub

'on mouse down
Sub OnMouseDown(cb As BANanoObject)
	stage.AddEventListener("stagemousedown", cb, False)
End Sub

'get mouse x
Sub GetMouseX As Long
	Dim res As Long = stage.getfield("mouseX").result
	Return res
End Sub

Sub GetMouseY As Long
	Dim res As Long = stage.getfield("mouseY").result
	Return res
End Sub

'enable mouse over
Sub EnableMouseOver
	stage.RunMethod("enableMouseOver",Null)
End Sub

'auto clear
Sub AutoClear(bClear As Boolean)
	stage.SetFIeld("autoClear",bClear)
End Sub

Sub EnableDOMEvents(bEvents As Boolean)
	stage.RunMethod("enableDOMEvents",Array(bEvents))
End Sub

'get the canvas width
Sub GetCanvasWidth As Long
	Dim res As Long = canvas.GetField("width").result
	Return res
End Sub

'get the canvas height
Sub GetCanvasHeight As Long
	Dim res As Long = canvas.GetField("height").result
	Return res
End Sub

'set paused
Sub SetPaused(p As Boolean)
	ticker.RunMethod("setPaused", Array(p))
End Sub

'get paused
Sub GetPaused() As Boolean
	Dim res As Boolean = ticker.RunMethod("getPaused",Null).result
	Return res
End Sub

'start game
Sub Prepare()
	'sound preparations
	createjs.Initialize("createjs")
	'get the sound object
	sound = createjs.GetField("Sound")
	'get the ticker
	ticker = createjs.GetField("Ticker")
	'get the touch
	touch = createjs.GetField("Touch")
	'
	queue.Initialize2("createjs.LoadQueue",Null)
	queue.RunMethod("installPlugin", Array(sound))
	Dim mSize As Int = manifests.size
	If mSize > 0 Then
		queue.AddEventListener("complete", BANano.CallBack(Me,"loadcomplete",Null), False)
		queue.RunMethod("loadManifest", Array(manifests))
	Else
		'we dont have any manifest resource
		loadComplete
	End If	
End Sub

'enable touch on the stage
Sub TouchEnable()
	touch.RunMethod("enable", Array(stage))	
End Sub

'start the ticker
Sub Start(FrameRate As Int)
	FPS = FrameRate
	ticker.SetField("framerate", FPS)
	ticker.AddEventListener("tick", BANano.CallBack(Me, "stageupdate", Null),False)
End Sub

'set FPS
Sub SetFPS(FrameRate As Int)
	FPS = FrameRate
	ticker.SetField("framerate", FPS)
End Sub

'clear
Sub Clear()
	stage.RunMethod("clear", Null)
End Sub

'contains
Sub Exists(i As BANanoObject) As Boolean
	Dim res As Boolean = stage.RunMethod("contains", Array(i)).Result
	Return res
End Sub

'the game has loaded
private Sub loadComplete()
	stage.Initialize2("createjs.Stage",Array(ID))
	'get the canvas
	canvas = stage.GetField("canvas")
	'call game_ready in the parent
	If SubExists(owner,"game_ready") Then
		BANano.CallSub(owner,"game_ready",Null)
	Else
		Log("game_ready is missing on host!")
	End If
End Sub

'get a resource from the manifest
Sub GetManifest(key As String) As BANanoObject
	Dim res As BANanoObject = queue.RunMethod("getResult", Array(key))
	Return res
End Sub

'get x position
Sub GetX(bo As BANanoObject) As Long
	Dim res As Long = bo.GetField("x").result
	Return res
End Sub

'get nextY position
Sub GetNextY(bo As BANanoObject) As Long
	Dim res As Long = bo.GetField("nextY").result
	Return res
End Sub

'get nextX position
Sub GetNextX(bo As BANanoObject) As Long
	Dim res As Long = bo.GetField("nextX").result
	Return res
End Sub


'update current Y by
Sub Add2Y(bo As BANanoObject, v As Long)
	'get last y
	Dim y As Long = GetY(bo)
	y = y + v
	SetY(bo,y)
End Sub

'update current Y by and return new value
Sub IncrementY(bo As BANanoObject, v As Long) As Long
	'get last y
	Dim y As Long = GetY(bo)
	y = y + v
	Return y
End Sub

'update current X by and return new value
Sub IncrementX(bo As BANanoObject, v As Long) As Long
	'get last x
	Dim x As Long = GetX(bo)
	x = x + v
	Return x
End Sub

'add a shape
Sub AddShape(csshape As CreateJSShape)
	AddChild(csshape.shape)
End Sub

'update current X by
Sub Add2X(bo As BANanoObject, v As Long)
	'get last x
	Dim x As Long = GetX(bo)
	X = X + v
	SetX(bo,X)
End Sub

'get y position
Sub GetY(bo As BANanoObject) As Long
	Dim res As Long = bo.GetField("y").result
	Return res
End Sub

'set x position
Sub SetX(bo As BANanoObject, v As Long)
	bo.SetField("x", v)	
End Sub

'set y position
Sub SetY(bo As BANanoObject, v As Long)
	bo.SetField("y", v)
End Sub

'set regX position i.e. registration point
Sub SetRegX(bo As BANanoObject, x As Int)
	bo.SetField("regX", x)
End Sub

'set y position i.e. registration point
Sub SetRegY(bo As BANanoObject, y As Int)
	bo.SetField("regY", y)
End Sub

'set nextX position
Sub SetNextX(bo As BANanoObject, x As Int)
	bo.SetField("nextX", x)
End Sub

'set nextY position
Sub SetNextY(bo As BANanoObject, y As Int)
	bo.SetField("nextY", y)
End Sub

'new bitmap
Sub NewBmp(source As BANanoObject) As BANanoObject
	Dim bmp As BANanoObject
	bmp.Initialize2("createjs.Bitmap", Array(source))
	Return bmp
End Sub

'sub sound interrupt none
Sub Sound_Interupt_None As BANanoObject
	Dim i As BANanoObject = createjs.GetField("Sound").GetField("INTERRUPT_NONE")
	Return i
End Sub

'play the sound
Sub Sound_Play3(mKey As String, interrupt As Object, o As Object) As BANanoObject
	Dim s As BANanoObject = sound.RunMethod("play", Array(mKey,interrupt, o))
	Return s
End Sub

'play the sound
Sub Sound_Play1(mKey As String)
	sound.RunMethod("play", Array(mKey))
End Sub


'tween quadout
Sub Ease_QuadOut As BANanoObject
	Dim qo As BANanoObject = createjs.GetField("Ease").GetField("quadOut")
	Return qo
End Sub

'tween bounceout
Sub Ease_BounceOut As BANanoObject
	Dim qo As BANanoObject = createjs.GetField("Ease").GetField("bounceOut")
	Return qo
End Sub

'update the stage each time the ticker fires
private Sub stageUpdate()
	If SubExists(owner,"game_update") Then
		BANano.CallSub(owner,"game_update", Null)
	Else
		Log("game_update is missing on host!")
	End If
End Sub

'remove child
Sub RemoveChild(bo As BANanoObject)
	stage.RunMethod("removeChild",Array(bo))
End Sub

'remove shape
Sub RemoveShape(s As CreateJSShape)
	RemoveChild(s.Shape)
End Sub

'get number of children
Sub GetNumChildren As Long
	Dim res As Int = stage.RunMethod("getNumChildren", Null)
	Return res
End Sub

'removeAllEventListeners();
Sub RemoveAllEventListeners
	stage.RunMethod("removeAllEventListeners",Null)
End Sub

'remove event listener
Sub RemoveEventListener(event As String, cb As BANanoObject)
	stage.RunMethod("removeEventListener", Array(event, cb))
End Sub

'update the stage
Sub Update
	stage.RunMethod("update", Null)
End Sub

'add a manifest to the game
Sub AddManifest(manid As String, mansrc As String)
	Dim m As Map = CreateMap()
	m.Put("id", manid)
	m.put("src", mansrc)
	manifests.Add(m)
End Sub

'add a child to the stage
Sub AddChild(bo As BANanoObject) As BANanoObject
	Dim res As BANanoObject = stage.RunMethod("addChild", Array(bo))
	Return res
End Sub

'add a sprite
Sub AddSprite(s As CreateJSSprite)
	AddChild(s.Sprite) 
End Sub

'add children
Sub AddChildren(lstOf As List)
	For Each child As BANanoObject In lstOf
		AddChild(child)
	Next
End Sub

'get the object to tween
Sub Tween_Get(target As BANanoObject, bLoop As Boolean)
	Dim opt As Map = CreateMap("loop": bLoop)
	tweenObject = createjs.GetField("Tween").RunMethod("get",Array(target,opt))
End Sub

'tween wait, the number of milliseconds to wait for the animation to start
Sub Tween_Wait(timeframe As Long)
	tweenObject.RunMethod("wait", Array(timeframe))
End Sub

'tween set properties
Sub Tween_Set(props As Map)
	tweenObject.RunMethod("set", Array(props))
End Sub

'tween with easing
Sub Tween_To3(props As Map, duration As Int, easing As BANanoObject)
	tweenObject.RunMethod("to", Array(props, duration, easing))
End Sub

'tween with duration only
Sub Tween_To2(props As Map, duration As Int)
	tweenObject.RunMethod("to", Array(props, duration))
End Sub

'function to call when the animation completes
Sub Tween_Call(bc As BANanoObject)
	tweenObject.RunMethod("call", Array(bc))
End Sub

'swap the children
Sub SwapChildren(c1 As BANanoObject, c2 As BANanoObject)
	stage.RunMethod("swapChildren", Array(c1,c2))
End Sub

'remove all children
Sub RemoveAllChildren
	stage.RunMethod("removeAllChildren", Null)
End Sub

'at child at position
Sub GetChildAt(i As Int) As BANanoObject
	Dim bo As BANanoObject = stage.RunMethod("getChildAt", Array(i))
	Return bo
End Sub

'set child index
Sub SetChildIndex(bo As BANanoObject, i As Int)
	stage.RunMethod("setChildIndex", Array(bo,i))
End Sub

