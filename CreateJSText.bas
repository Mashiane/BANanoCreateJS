B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Text As BANanoObject
End Sub

Public Sub Initialize(sText As String, sFont As String, sColor As String) As CreateJSText
	Text.Initialize2("createjs.Text", Array(sText, sFont, sColor))
	Return Me
End Sub

'set x
Sub SetX(x As Int) As CreateJSText
	Text.SetField("x", x)
	Return Me
End Sub

'set y
Sub SetY(y As Int) As CreateJSText
	Text.SetField("y", y)
	Return Me
End Sub

'set text baseline
Sub SetTextBaseLine(bs As Object) As CreateJSText
	Text.SetField("textBaseline", bs)
	Return Me
End Sub

'set text align
Sub SetTextAlign(t As Object) As CreateJSText
	Text.SetField("textAlign", t)
	Return Me
End Sub