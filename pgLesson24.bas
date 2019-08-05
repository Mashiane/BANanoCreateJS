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
	
End Sub

Sub Init
	'
	Dim gameHolder As UOENowHTML
	gameHolder.Initialize("gameHolder", "div")
	'
	Dim instructions As UOENowHTML
	instructions.Initialize("instructions", "div").SetStyle("visibility","hidden")
	instructions.SetStyle("width", "400px").SetStyle("height","300px").SetStyle("border","dashed 2 #008b8b")
	instructions.SetStyle("text-align","center")
	'
	Dim h3 As UOENowHTML
	h3.Initialize("","h3").SetStyle("font-family","arial").AddContent("Game Instructions")
	instructions.AddElement(h3)
	'
	Dim p1 As UOENowHTML
	p1.Initialize("","p").AddStrong("Click").AddContent(" on the ").AddSpan("RED", CreateMap("color":"red"))
	p1.AddContent(" balloons as they fall from the sky.")
	instructions.AddElement(p1)
	'
	Dim p2 As UOENowHTML
	p2.Initialize("","p").AddContent("Make sure you click them ")
	p2.AddSpan("all", CreateMap("text-decoration":"underline"))
	p2.AddContent(" before time runs out!")
	instructions.AddElement(p2)
	'
	Dim p3 As UOENowHTML
	p3.Initialize("","p").AddContent("Rack up ").AddItalic("as many points",Null)
	p3.AddContent(" as you can to reach the ").AddSpan("BLUE", CreateMap("color":"blue"))
	p3.AddContent(" level.")
	instructions.AddElement(p3)
	'
	Dim h2 As UOENowHTML
	h2.Initialize("","h2").AddContent("GOOD LUCK!")
	h2.SetStyle("font-weight", "bold")
	h2.SetStyle("margin-top","30px")
	instructions.addelement(h2)
	'
	Dim div As UOENowHTML
	div.Initialize("canvasparent","div")
	'
	gameHolder.AddElement(instructions)
	gameHolder.AddElement(div)
	'
	BANano.GetElement("#body").Empty
	BANano.GetElement("#body").Append(gameHolder.HTML) 
	
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "canvasparent", "canvas", 400, 400, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	Dim el As CreateJSDOMElement
	el.Initialize("instructions")
	el.SetAlpha(0)
	el.SetRegX(200)
	el.SetX(game.GetCanvasWidth / 2)
	game.addChild(el.DOMElement)
	'
	game.Tween_Get(el.DOMElement,False)
	game.Tween_Wait(1000)
	game.tween_to3(CreateMap("y": 40, "alpha": 1), 2000, game.Ease_QuadOut)
	game.Start(60)
End Sub

Sub game_update
	game.update
End Sub