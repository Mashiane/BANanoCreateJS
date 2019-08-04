B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private game As BANanoCreateJS
	Private BANano As BANano  'ignore
	Private circle As CreateJSShape
End Sub

'tranform images

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 800, 600, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	circle.Initialize2(game)
	circle.graphics.beginFill("red")
	circle.graphics.drawCircle(0, 0, 25)
	circle.SetCache(-25, -25, 50, 50)
	circle.Add
	game.update
	'
	Dim img As CreateJSImage
	Dim e As BANanoEvent
	img.Initialize("./assets/butterfly.png", BANano.CallBack(Me, "butterfly_load", Array(e)))
End Sub

Sub butterfly_load(e As BANanoEvent)
	Dim trg As BANanoObject = game.GetEventTarget(e)
	'
	Dim bitmap As CreateJSBitmap
	bitmap.Initialize(trg)
	
	Dim width As Int = bitmap.getimagewidth
	Dim height As Int = bitmap.getimageheight
	bitmap.SetCache(0, 0, width, height)
	'
	game.addChild(bitmap.BitMap)
	game.update
End Sub
