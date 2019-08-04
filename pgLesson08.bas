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
	Private const LOADER_WIDTH As Long = 400
	Private loaderBar As CreateJSShape
	Private loadInterval As Int
	Private percentLoaded As Double = 0
End Sub

Sub Init
	'create the canvas and the stage for the game to be created
	BANano.GetElement("#body").SetStyle(BANano.ToJson(CreateMap("margin": "20px")))
	game.Initialize(Me, "body", "canvas", 1024, 768, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	buildLoaderBar
	startLoad
	'start the game at 60 frames per second
	game.Start(60)
End Sub

'create a blank rectangle
Sub buildLoaderBar
	loaderBar.Initialize
	loaderBar.setx(100)
	loaderBar.sety(100)
	loaderBar.graphics.setStrokeStyle(2)
	loaderBar.graphics.beginStroke("#000")
	loaderBar.graphics.drawRect(0, 0, LOADER_WIDTH, 40)
	game.AddShape(loaderBar)
End Sub

Sub updateLoaderBar
	Dim nw As Long = LOADER_WIDTH * percentLoaded
	loaderBar.graphics.clear
	loaderBar.graphics.beginFill("#00ff00")
	loaderBar.graphics.drawRect(0, 0, nw, 40)
	loaderBar.graphics.endFill()
	loaderBar.graphics.setStrokeStyle(2)
	loaderBar.graphics.beginStroke("#000")
	loaderBar.graphics.drawRect(0, 0, LOADER_WIDTH, 40)
	loaderBar.graphics.endStroke()
End Sub

Sub startLoad
	Dim cb As BANanoObject = BANano.CallBack(Me,"updateload",Null)
	loadInterval = BANano.Window.setInterval(cb, 50)
End Sub

Sub updateLoad
	percentLoaded = percentLoaded + 0.005
	updateLoaderBar
	If percentLoaded >= 1 Then
		BANano.Window.ClearInterval(loadInterval)
		game.removeChild(loaderBar.shape)
	End If
End Sub

Sub game_update
	game.update
End Sub
