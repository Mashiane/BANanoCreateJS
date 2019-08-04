B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Text As BANanoObject
End Sub

Public Sub Initialize(sText As String, sFont As String, sColor As String)
	Text.Initialize2("createjs.Text", Array(sText,sFont,sColor))
End Sub

Sub SetX(x As Int)
	Text.SetField("x", x)
End Sub

Sub SetY(y As Int)
	Text.SetField("y", y)
End Sub