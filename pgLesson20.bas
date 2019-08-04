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
	Private bg As CreateJSShape
	Private mask As CreateJSShape
End Sub

'vector masks (we have a red circle)

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	mask.Initialize
	mask.graphics.drawCircle(0, 0, 30)
	mask.setx(100)
	mask.sety(100)
	'
	bg.Initialize
	bg.graphics.clear
	bg.graphics.beginFill("red")
	bg.graphics.rect(0, 0, 400, 400)
	bg.setmask(mask)
	'
	Dim e As BANanoEvent
	bg.addEventListener("mousedown", BANano.CallBack(Me, "handlePress", Array(e)))
	
	game.addChild(bg.Shape)
	game.update
End Sub

Sub handlePress(e As BANanoEvent)
	Dim shp As CreateJSShape = game.GetEventShape(e)
	shp.addEventListener("mousemove", BANano.CallBack(Me, "handleMove", Null))
End Sub

Sub handleMove(e As BANanoEvent)
	mask.setx(game.GetMouseX)
	mask.sety(game.getmouseY)
	game.update
End Sub

Sub game_update
	game.update
End Sub