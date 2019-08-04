B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Image As BANanoObject
End Sub

'Initializes the image
Public Sub Initialize(imgURL As String, cbOnLoad As BANanoObject)
	Image.Initialize2("Image",Null)
	Image.SetField("src", imgURL)
	Image.AddEventListener("load", cbOnLoad, True) 
End Sub

Sub GetWidth As Int
	Dim res As Int = Image.GetField("width")
	Return res
End Sub

Sub GetHeight As Int
	Dim res As Int = Image.GetField("height")
	Return res
End Sub