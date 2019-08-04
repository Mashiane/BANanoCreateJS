B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Graphic As BANanoObject
End Sub

Sub Initialize() As CreateJSGraphic
	Graphic.Initialize2("createjs.Graphics", Null)
	Return Me
End Sub

Sub BeginStroke(s As String) As CreateJSGraphic
	Graphic.RunMethod("beginStroke", Array(s))
	Return Me
End Sub

Sub BeginFill(f As String) As CreateJSGraphic
	Graphic.RunMethod("beginFill", Array(f))
	Return Me
End Sub	

Sub DrawRect(a As Object, b As Object, c As Object, d As Object)
	Graphic.RunMethod("drawRect", Array(a,b,c,d))
End Sub
