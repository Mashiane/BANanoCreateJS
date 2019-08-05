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

Public Sub Initialize(sText As String, sFont As String, SColor As String) As CreateJSText
	Text.Initialize2("createjs.Text", Array(sText, sFont, SColor))
	Return Me
End Sub

Public Sub Initialize1(sText As String) As CreateJSText
	Text.Initialize2("createjs.Text", Array(sText))
	Return Me
End Sub

Public Sub Initialize2(sText As String, sFont As String) As CreateJSText
	Text.Initialize2("createjs.Text", Array(sText, sFont))
	Return Me
End Sub

'set font
Sub SetFont(f As Object) As CreateJSText
	Text.SetField("font", f)
	Return Me
End Sub

'set alpha
Sub SetAlpha(f As Object) As CreateJSText
	Text.SetField("alpha", f)
	Return Me
End Sub

'set text
Sub SetText(t As Object) As CreateJSText
	Text.SetField("text", t)
	Return Me
End Sub

'set color
Sub SetColor(c As Object) As CreateJSText
	Text.SetField("color", c)
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