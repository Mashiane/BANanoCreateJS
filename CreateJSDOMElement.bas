B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public DOMElement As BANanoObject
End Sub

Public Sub Initialize(elID As String) As CreateJSDOMElement
	DOMElement.Initialize2("createjs.DOMElement", Array(elID))
	Return Me
End Sub

'set x
Sub SetX(x As Int) As CreateJSDOMElement
	DOMElement.SetField("x", x)
	Return Me
End Sub

'set y
Sub SetY(y As Int) As CreateJSDOMElement
	DOMElement.SetField("y", y)
	Return Me
End Sub

Sub SetAlpha(y As Int) As CreateJSDOMElement
	DOMElement.SetField("alpha", y)
	Return Me
End Sub

Sub SetRegX(y As Int) As CreateJSDOMElement
	DOMElement.SetField("regX", y)
	Return Me
End Sub
