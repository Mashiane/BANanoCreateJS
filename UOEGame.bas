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
End Sub

'start game
Sub Start(FrameRate As Int)
	FPS = FrameRate
	'sound preparations
	createjs.Initialize("createjs")
	'sound = createjs.GetField("Sound")
	'
	'queue = new createjs.LoadQueue();
	queue.Initialize2("createjs.LoadQueue",Null)
	'queue.installPlugin(createjs.Sound)
	'queue.RunMethod("installPlugin", Array(sound))
	'queue.addEventListener("complete", loadComplete);
	queue.AddEventListener("complete", BANano.CallBack(Me,"loadcomplete",Null), False)
	'queue.loadManifest([]);
	queue.RunMethod("loadManifest", Array(manifests))
End Sub

'the game has loaded
private Sub loadComplete()
	'stage = new createjs.Stage(document.getElementById('canvas'));
	Dim doc As BANanoObject = BANano.Window.GetField("document")
	Dim cvs As BANanoObject = doc.RunMethod("getElementById",Array(ID))
	stage.Initialize2("createjs.Stage",Array(cvs))
	'createjs.Ticker.setFPS(60);
	createjs.GetField("Ticker").SetField("framerate", FPS)
	'createjs.Ticker.addEventListener("tick", function(){ 
		'stage.update();
	'});
	createjs.GetField("Ticker").AddEventListener("tick", BANano.CallBack(Me, "stageupdate", Null),False)
	'call game_ready in the parent
	If BANano.SubExists(owner,"game_ready") Then
		BANano.CallSub(owner,"game_ready",Null)
	Else
		Log("game_ready is missing on host!")
	End If
End Sub

'get a resource from the manifest
Sub getManifest(key As String) As BANanoObject
	Dim res As BANanoObject = queue.RunMethod("getResult", Array(key))
	Return res
End Sub

'set x position
Sub SetX(bo As BANanoObject, v As Long)
	bo.SetField("x", v)	
End Sub

'new bitmap
Sub NewBmp(source As BANanoObject) As BANanoObject
	Dim bmp As BANanoObject
	bmp.Initialize2("createjs.Bitmap", Array(source))
	Return bmp
End Sub

'tween quadout
Sub Ease_QuadOut As BANanoObject
	Dim qo As BANanoObject = createjs.GetField("Ease").GetField("quadOut")
	Return qo
End Sub

'update the stage
private Sub stageUpdate()
	If BANano.SubExists(owner,"game_update") Then
		BANano.CallSub(owner,"game_update", Null)
	Else
		Log("game_update is missing on host!")
	End If
End Sub

'remove child
Sub RemoveChild(bo As BANanoObject)
	stage.RunMethod("removeChild",Array(bo))
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
Sub AddChild(bo As BANanoObject)
	stage.RunMethod("addChild", Array(bo))
End Sub

Sub Tween_Get(target As BANanoObject)
	tweenObject = createjs.GetField("Tween").RunMethod("get",Array(target))
End Sub

Sub Tween_Wait(timeframe As Long)
	tweenObject.RunMethod("wait", Array(timeframe))
End Sub

Sub Tween_To3(a As Object, b As Object, c As Object)
	tweenObject.RunMethod("to", Array(a, b, c))
End Sub

Sub Tween_Call(bc As BANanoObject)
	tweenObject.RunMethod("call", Array(bc))
End Sub