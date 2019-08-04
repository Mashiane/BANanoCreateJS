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
	Private bg As CreateJSBitmap
	Private mask As CreateJSShape
	Private img As CreateJSImage
End Sub

'vector masks (for images)

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(Me, "image_load", Array(e))
	img.Initialize("./assets/butterfly.png", cb)
End Sub

Sub image_load(e As BANanoEvent)
	'create the mask layer
	mask.Initialize
	mask.setx(img.getwidth / 2)
	mask.sety(img.getheight / 2)
	mask.graphics.drawCircle(0, 0, 100)
	'
	Dim bg As CreateJSBitmap
	bg.Initialize(img.Image)
	bg.AddFilter(game.NewBlurFilter(50,50,10)) 
	bg.SetFilters
	bg.SetCache(0,0,img.getwidth,img.getheight)
	bg.setmask(mask)
	game.addChild(bg.bitmap)
	game.update
End Sub

Sub game_update
	game.update
End Sub