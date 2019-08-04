B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private game As BANanoCreateJS
	Private BANano As BANano  'ignore
	Private ss As CreateJSSpriteSheet
	Private grant As CreateJSSprite
End Sub

'tranform images

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 960, 400, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	ss.Initialize("ss").AddImage("./assets/grant.png")
	'height of each sprite, width, registrations, count
	ss.SetRegX(82)
	ss.SetHeight(292)
	ss.SetCount(64)   ' the number of image frames in the sprite
	ss.SetRegY(0)
	ss.SetWidth(165)   ' the width of each image
	ss.SetFrameRate(30)  ' the frame rate
	'animation, starting sprite, ending sprite, next animation, speed
	ss.AddSimpleAnimation("run", 0, 25, "run", 1.5)   ' specify the animation, the start and ending image and the speed
	ss.AddSimpleAnimation("jump", 26, 63, "run", -1)
	'build the sprite to make it available to the game
	ss.BuildSpriteSheet 
	'
	'create the sprite and add it to the stage
	grant.Initialize(ss, "grant", "run") 
	grant.setx(game.getcanvaswidth / 2)
	grant.sety(22)
	game.AddSprite(grant)
	'
	game.Start(30)
End Sub


Sub game_update
	game.update
End Sub