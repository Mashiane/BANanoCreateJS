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
	Private livesTxt As CreateJSText
	Private gameOverTxt As CreateJSText
	Private win As Boolean
	Private answer As String = "CREATEJS IS&AWESOME"
	Private abc As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	Private lives As Int = 5
	Private lettersNeeded As Int = 0
End Sub

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 400, 400, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	drawBoard
	drawLetters
	drawMessages
	startGame
End Sub

'these are all the words we need
Sub drawBoard
	Dim schar As String
	Dim i As Int
	Dim xPos As Int = 20
	Dim yPos As Int = 90
	Dim abcLen As Int = answer.Length - 1
	'
	For i = 0 To abcLen
		schar = answer.SubString2(i,i+1)
		If (schar <> " ") And (schar <> "&") Then
			lettersNeeded = lettersNeeded + 1
			Dim box As CreateJSShape
			box.Initialize 
			box.graphics.beginStroke("#000")
			box.graphics.drawRect(0, 0, 20, 24)
			box.SetRegX(10)
			box.SetRegY(12)
			box.SetX(xPos)
			box.SetY(yPos)
			box.SetName("box_" & i)
			box.SetKey(schar)
			game.addChild(box.Shape)
		End If
		xPos = xPos + 26
		If schar = "&" Then
			yPos = yPos + 40
			xPos = 20
		End If
	Next
End Sub

Sub drawLetters
	Dim i As Int
	Dim schar As String
	Dim cnt As Int = 0
	Dim xPos As Int = 20
	Dim yPos As Int = 200
	Dim abcLen As Int = abc.length - 1
	For i = 0 To abcLen
		schar = abc.SubString2(i,i+1) 
		Dim btn As CreateJSShape
		btn.initialize
		btn.graphics.beginFill("#000")
		btn.graphics.beginStroke("#000")
		btn.graphics.drawRect(0, 0, 20, 24)
		btn.regX(10)
		btn.regY(12)
		btn.setx(xPos)
		btn.sety(yPos)
		game.addChild(btn.Shape)
		
		'create text
		Dim txt As CreateJSText
		txt.initialize1(schar)
		txt.setcolor("#FFF")
		txt.settextAlign("center")
		txt.settextBaseline("middle")
		txt.setx(xPos)
		txt.sety(yPos)
		game.addChild(txt.text)
		'
		btn.Settxt(txt.Text)
		Dim e As BANanoEvent
		btn.addEventListener("click", BANano.CallBack(Me, "onLetterClick", Array(e)))
		'adjust positions
		xPos = xPos + 24
		cnt = cnt + 1
		If (cnt = 13) Then
			yPos = yPos + 30
			xPos = 20
		End If
	Next
End Sub

Sub onLetterClick(e As BANanoEvent)
	Dim btn As BANanoObject = game.GetEventTarget(e)
	Dim txt As BANanoObject = btn.GetField("txt")
	'Dim e As BANanoEvent
	'btn.removeEventListener("click", BANano.CallBack(Me, "onLetterClick", Array(e)))
	checkForMatches(txt)
	checkGame
End Sub

Sub checkGame
	If (lettersNeeded = 0) Then
		win = True
		gameOver
	else if (lives = 0) Then
		win = False
		gameOver
	End If
End Sub

Sub gameOver() {
	game.removeAllChildren
	Dim msg As String
	If win Then 
		msg = "YOU WIN!"
	Else
		msg = "YOU LOSE"
	End If
	gameOverTxt.Initialize2(msg, "36px Arial")
	gameOverTxt.Setalpha(0)
	Dim scolor As String
	If win Then
		scolor = "true"
	Else
		scolor = "red"
	End If
	gameOverTxt.Setcolor(scolor)
	gameOverTxt.SettextAlign("center")
	gameOverTxt.SettextBaseline("middle")
	gameOverTxt.Setx(game.GetCanvasWidth / 2)
	gameOverTxt.Sety(game.Getcanvasheight / 2)
	game.addChild(gameOverTxt.Text)
	game.Tween_Get(gameOverTxt.text,False)
	game.Tween_To2(CreateMap("alpha":1),1000)
End Sub

Sub checkForMatches(txt As BANanoObject)
	Dim letter As String = txt.GetField("text").result
	Dim i As Int
	Dim match As Boolean = False
	Dim l As Int = answer.length - 1 
	For i = 0 To l
		Dim schar As String = answer.SubString2(i,i+1)
		If (schar = " " Or schar = "&") Then
			Continue
		End If
		Dim box As BANanoObject = game.getChildByName("box_" & i)
		Dim key As String = box.GetField("key").result
		Dim boxx As Int = box.GetField("x").result
		Dim boxy As Int = box.GetField("y").result
		If (key = letter) Then
			lettersNeeded = lettersNeeded - 1
			match = True
			Dim txtClone As BANanoObject
			txtClone = txt.RunMethod("clone", Null)
			txtClone.SetField("color", "#000")
			txtClone.SetFIeld("x", boxx)
			txtClone.SetField("y", boxy)
			game.AddChild(txtClone)
		End If
	Next
	game.removeChild(txt)
	If (match = False) Then
		lives = lives -1
		livesTxt.SetText("LIVES: " & lives)
	End If
End Sub


Sub drawMessages
	Dim txt As CreateJSText
	txt.Initialize2("WORD GAME", "26px Arial")
	txt.SetColor("#99000")
	txt.Setx(10)
	txt.sety(10)
	game.addChild(txt.text)
	'
	livesTxt.Initialize2("LIVES: " & lives, "16px Arial")
	livesTxt.SettextAlign("right")
	livesTxt.Sety(16)
	livesTxt.Setx(game.GetCanvasWidth - 10)
	game.addChild(livesTxt.text)
End Sub

Sub startGame
	game.Start(60)
End Sub

Sub game_update
	game.update
End Sub