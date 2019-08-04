B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Graphics As BANanoObject
End Sub

Sub Initialize()
	Graphics.Initialize2("createjs.Graphics", Null)
End Sub

'initialize from an existing object
Sub Initialize1(grp As BANanoObject)
	Graphics = grp
End Sub

Sub Clear()
	Graphics.RunMethod("clear", Null)
End Sub

Sub SetStrokeStyle3(stroke As Int, b As Object, c As Object)
	Graphics.RunMethod("setStrokeStyle", Array(stroke, b, c))
End Sub

Sub CurveTo(x As Int, y As Int, x1 As Int, y1 As Int)
	Graphics.RunMethod("curveTo", Array(x, y, x1, y1))
End Sub



Sub Rect(x As Int, y As Int, width As Int, height As Int)
	Graphics.RunMethod("rect", Array(x, y, width, height))
End Sub


Sub EndFill
	Graphics.RunMethod("endFill", Null)
End Sub

Sub EndStroke
	Graphics.RunMethod("endStroke", Null)
End Sub


Sub BeginStroke(s As String)
	Graphics.RunMethod("beginStroke", Array(s))
End Sub

Sub BeginFill(f As String)
	Graphics.RunMethod("beginFill", Array(f))
End Sub	

Sub DrawRect(x As Long, y As Long, width As Long, height As Long)
	Graphics.RunMethod("drawRect", Array(x,y,width,height))
End Sub

Sub DrawCircle(x As Long, y As Long, radius As Long)
	Graphics.RunMethod("drawCircle", Array(x, y, radius))
End Sub

Sub DrawPolyStar(a As Long,b As Long, c As Long, d As Long, e As Double)
	Graphics.RunMethod("drawPolyStar", Array(a, b, c, d, e))
End Sub

Sub MoveTo(x As Long, y As Long)
	Graphics.RunMethod("moveTo", Array(x, y))
End Sub

Sub LineTo(x As Long, y As Long)
	Graphics.runmethod("lineTo", Array(x, y))
End Sub

Sub drawRoundRect(a As Long, b As Long, c As Long, d As Long, e As Long)
	Graphics.RunMethod("drawRoundRect", Array(a, b, c, d, e))
End Sub

Sub SetStrokeStyle(s As Int)
	Graphics.runmethod("setStrokeStyle", Array(s))
End Sub
