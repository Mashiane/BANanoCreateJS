B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Bitmap As BANanoObject
	Public Image As BANanoObject
	Private sourceB As BANanoObject
	Private filters As List
End Sub

'Initializes the bitmap
Public Sub Initialize(source As BANanoObject)
	sourceB = source
	Bitmap.Initialize2("createjs.Bitmap", Array(source))
	Image = Bitmap.GetField("image")
	filters.Initialize 
End Sub

'add a filter
Sub AddFilter(b As BANanoObject)
	filters.Add(b)
End Sub

'set the filters
Sub SetFilters
	Bitmap.SetField("filters", filters)
End Sub

'get image width
Sub GetImageWidth As Int
	Dim w As Int = Image.GetField("width")
	Return w
End Sub

'get image height
Sub GetImageHeight As Int
	Dim h As Int = Image.GetField("height")
	Return h
End Sub

'clone bitmap
Sub Clone() As CreateJSBitmap
	Dim res As CreateJSBitmap
	res.Initialize(sourceB)
	Return res
End Sub

'cache (x, y, width, height, [scale=1])
Sub SetCache(x As Int, y As Int, width As Int, height As Int)
	Bitmap.RunMethod("cache", Array(x, y, width, height))
End Sub


Sub SetMask(msk As CreateJSShape)
	Bitmap.SetField("mask", msk.Shape)
End Sub

'set regy
Sub SetRegY(regY As Int)
	Bitmap.SetField("regY", regY)
End Sub

'set rotation
Sub SetRotation(r As Int)
	Bitmap.SetField("rotation", r)
End Sub

'set scalex
Sub SetScaleX(scaleX As Double)
	Bitmap.SetField("scaleX", scaleX)
End Sub

'sety
Sub SetY(y As Int)
	Bitmap.SetField("y", y)
End Sub

'setx
Sub SetX(y As Int)
	Bitmap.SetField("y", y)
End Sub