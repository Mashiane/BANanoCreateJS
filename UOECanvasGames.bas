B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public ID As String
	Private BANano As BANano 'ignore
	Private owner As Object
	Private cnvas As BANanoObject
	Private ctx As BANanoObject
	Private doc As BANanoObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object, container As String, gid As String, Width As Int, Height As Int, classes As String, styles As Map)
	Dim el As BANanoElement
	ID = gid.tolowercase
	container = container.tolowercase
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
	Log(cvas.HTML)
	'
	'get the document object
	doc = BANano.Window.GetField("document")
	'get the canvas
	cnvas = doc.RunMethod("getElementById", Array(ID))
	'get the context
	ctx = cnvas.RunMethod("getContext", Array("2d"))
	'
	owner = Module
	'the game board is ready
	If BANano.SubExists(owner,"game_ready") Then
		BANano.CallSub(owner,"game_ready",Null)
	End If
End Sub

Sub DrawImage(img As BANanoObject,a As Object,b As Object,c As Object,d As Object,e As Object,f As Object,g As Object,h As Object)
	ctx.RunMethod("drawImage", Array(a,b,c,d,e,f,g,h))
End Sub

Sub NewBmp(imgPath As String) As BANanoObject
	Dim bmp As BANanoObject
	bmp.Initialize2("Image",Null)
	bmp.SetField("src", imgPath) 
	'
	Dim cb As BANanoObject = BANano.CallBack(Me,"newimage", Array(bmp))
	bmp.SetField("onload", cb)
End Sub

Sub newimage(bmp As BANanoObject)
	If BANano.SubExists(owner,"new_image") Then
		BANano.CallSub(owner,"new_image",Array(bmp))
	End If
End Sub