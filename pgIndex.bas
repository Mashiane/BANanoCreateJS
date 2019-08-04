B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private BANano As BANano  'ignore
	Dim game As BANanoCreateJS
End Sub

Sub Init
	'initialize the game
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'add resources to the manifest for the game
	game.AddManifest("butterfly", "./assets/butterfly.png")
	game.AddManifest("woosh", "./assets/woosh.mp3")
	game.AddManifest("chime", "./assets/chime.mp3")
	'prepare the stage
	game.Prepare
End Sub

'when the FPS is kicking
Sub game_update
	Log("game_update")
	'you can process anything here to change the game objects
	game.Update
End Sub

'after the game is loaded and the stage is ready for drawing
Sub game_ready()
	Log("game_ready") 'here we create our game
	
	'var img = queue.getResult("butterfly");
	Dim img As BANanoObject = game.getManifest("butterfly")
	'var i, sound, butterfly;
	Dim i As Int
	'Dim sound As BANanoObject
	'Dim interrupt As Object
	'For (i = 0; i < 3; i++) {
	For i = 1 To 3
		'butterfly = new createjs.Bitmap(img);
		Dim butterfly As BANanoObject = game.NewBmp(img)
		'butterfly.x = i * 200;
		game.SetX(butterfly, i*200)
		'stage.addChild(butterfly);
		Dim child As BANanoObject = game.AddChild(butterfly)
		
		'createjs.Tween.get(butterfly).wait(i * 1000).to({y:100}, 1000, createjs.Ease.quadOut).call(butterflyComplete);
		game.Tween_Get(butterfly, True)
		game.Tween_Wait(i * 1000)
		game.Tween_To3(CreateMap("y":100), 1000, game.Ease_QuadOut)
		game.Tween_Call(BANano.CallBack(Me, "butterflycomplete", Array(child)))
		
		'*****
		'sound = createjs.Sound.play('woosh',createjs.Sound.INTERRUPT_NONE,i * 1000);
		'Dim interrupt As Object = game.createjs.GetField("Sound").GetField("INTERRUPT_NONE")
		'sound = game.createjs.GetField("Sound").RunMethod("play", Array("woosh", interrupt, i * 1000))
	Next
	'start the game at 60 FPS
	game.Start(60)
End Sub

Sub butterflyComplete(bo As BANanoObject)
	Log("complete")
	Log(bo)
	game.RemoveChild(bo)
End Sub


