B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public ID As String
	Public Sprite As BANanoObject
	Private SpriteSheet As BANanoObject
End Sub

'Initializes the sprite
Public Sub Initialize(ss As CreateJSSpriteSheet, sID As String, animation As String)
	'get the spritesheet
	SpriteSheet = ss.SpriteSheet
	Sprite.Initialize2("createjs.Sprite", Array(SpriteSheet, animation))
End Sub

'play the sprite
Sub Play
	Sprite.RunMethod("play",Null)
End Sub

'set x position
Sub SetX(x As Int)
	Sprite.SetField("x", x)
End Sub

'set y position
Sub SetY(y As Int)
	Sprite.SetField("y", y)
End Sub
