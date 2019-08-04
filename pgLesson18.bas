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
	'create the mask, this is a circle without a color
	mask.Initialize 
	mask.graphics.drawCircle(0, 0, 30)
	mask.setx(100)
	mask.sety(100)

	' Create a red background */
	bg.Initialize 
	bg.graphics.clear()
	bg.graphics.beginFill("red")
	bg.graphics.rect(0, 0, 400, 200)
	' Add mask To background */
	bg.Setmask(mask)
	' Add To stage */
	game.addChild(bg.Shape)
	' update stage in usual way */
	game.update
End Sub

Sub game_update
	game.update
End Sub