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
	Dim shapes As List
	Dim slots As List
	Dim score As Int
	Dim dragshape As CreateJSShape
	Dim slot As CreateJSShape
End Sub

'Color Drop Is a simple color-matching game where the player must drop each game piece in the correct slot by
'matching their colors.
'• Four square slots are displayed on the top of the screen.
'• Four blocks are randomly placed on the bottom of the screen, each with a color that matches a
'slot at the top of the screen.
'• The player must drag each block into its corresponding slot, which Is accomplished by
'matching their colors.
'• If a player drops it in the wrong slot, the block will animate back To where it was grabbed.
'• If a player drops it in the correct slot, it should animate To snap in place of the slot.
'• Once the player fills all four slots, alert the user that they have won the game.

Sub Init
	'create the canvas and the stage for the game to be created
	game.Initialize(Me, "body", "canvas", 1000, 800, "", CreateMap("border": "black solid 1px"))
	'prepare the stage
	game.Prepare
End Sub

Sub game_ready
	shapes.Initialize
	slots.Initialize
	score = 0
	'
	buildShapes
	setBlocks
	game.Start(60)
End Sub

'detect keyboard
Sub game_keyup(e As BANanoEvent)
	Log(e.KeyCode)
End Sub

'detect the key that has been pressed!
Sub game_keydown(e As BANanoEvent)
	Log(e.KeyCode)
End Sub

'ticker is firing
Sub game_update
	game.update
End Sub

'The buildShapes function creates all of the visual assets needed for the game
'the blocks are simply instantiated And pushed To an Array so you can draw them later at random positions.
'A key property Is assigned To each slot And block using the iterator value, And can be used later in the game To
'determine matches when you drop blocks on the slots
Sub buildShapes
	'add the colors to use for the shapes
	Dim colors As List
	colors.Initialize
	colors.Add("blue")
	colors.Add("red")
	colors.Add("green")
	colors.Add("orange")
	'
	Dim i As Int
	Dim colTot As Int = colors.size - 1
	'
	For i = 0 To colTot
		'slots
		Dim slot As CreateJSShape
		slot.initialize
		Dim strCol As String = colors.get(i)
		slot.graphics.beginStroke(strCol)
		slot.graphics.beginFill("#FFF")
		slot.graphics.drawRect(0, 0, 100, 100)
		'registration x and y, half of width / height
		slot.SetregX(50)
		slot.SetregY(50)
		slot.setkey(i)
		slot.sety(80)
		slot.setx((i * 130) + 100)
		'add to game
		game.AddChild(slot.shape)
		'save in the list
		slots.add(slot)
		'shapes
		Dim shape As CreateJSShape
		shape.initialize
		shape.graphics.beginFill(strCol)
		shape.graphics.drawRect(0, 0, 100, 100)
		shape.setregX(50)
		shape.setregY(50)
		shape.setkey(i)
		'save in the list
		shapes.add(shape)
	Next
End Sub

'Each iteration grabs a random index out of the shapes Array before placing it on the screen
'As you randomly choose and draw each block, you also set a few properties to them for reference on where it was
'initially drawn. This lets you put it back to this position if you incorrectly drop it somewhere else on the stage.
'Finally, a mousedown event listener is registered to each shape so you can create its dragging functionality
Sub setBlocks
	Dim i As Int
	Dim r As Int
	Dim shape As CreateJSShape
	Dim l As Int = shapes.size - 1
	For i = 0 To l
		'
		Dim proc As Int = game.math_random * shapes.Size
		r = game.math_floor(proc)
		'
		shape = shapes.Get(r)
		shape.sethomeY(320)
		shape.sethomeX((i * 130) + 100)
		shape.sety(shape.gethomeY)
		shape.setx(shape.gethomeX)
		Dim e As BANanoEvent
		Dim cb As BANanoObject = BANano.CallBack(Me, "startdrag", Array(e))
		shape.OnMouseDown(cb)
		game.addChild(shape.shape)
		'remove it so we dont grap it again
		shapes.RemoveAt(r)
	Next
End Sub

'This function acts as the event handler when a block has been grabbed and also handles the entirety of the game logic.
Sub startDrag(e As BANanoEvent)
	'get the target from the event
	'the blocks and slots are linked using the key
	'Since the slots were never shuffled, their keys match their index in the Array that holds the reference To them.
	dragshape = game.GetEventShape(e)
	slot = slots.Get(dragshape.GetKey)
	'the child layer you want to access and layer to move to
	game.setChildIndex(dragshape.Shape, game.getNumChildren - 1)
	'
	Dim cb As BANanoObject = BANano.CallBack(Me,"game_mousemove",Array(e))
	game.OnMouseMove(cb)
	'
	Dim cb1 As BANanoObject = BANano.CallBack(Me, "game_mouseup", Array(e))
	game.OnMouseUp(cb1)
End Sub

Sub game_mouseup(e As BANanoEvent)
	game.removeAllEventListeners
	'where was the mouse pointer when the drag was released i.e. the center of the dragged object
	'perform a hittest to determine if we have right slot under the mouse
	Dim hitTest As Boolean = dragshape.GetHitTest(game)
	If hitTest Then
		' if on right slot, remove the event, increment the score and tween it inside the slot
		Dim e As BANanoEvent
		Dim cb As BANanoObject = BANano.CallBack(Me, "startdrag", Array(e))
		dragshape.RemoveEventListener("mousedown", cb)
		
		'update the score
		score = score + 1
		'get the slots x and y
		Dim x As Int = slot.GetX
		Dim y As Int = slot.gety
		Dim props As Map = CreateMap()
		props.Put("x", x)
		props.Put("y", y)
		Dim call As BANanoObject = BANano.CallBack(Me, "game_checkgame", Null)
		'tween the block to sit inside the slot
		game.Tween_Get(dragshape.Shape,False)
		game.tween_to3(props, 200, game.Ease_QuadOut)
		game.Tween_Call(call)
		'tell user he won 
	Else
		'we are not in the right position
		'get the original home position and pot shape back
		Dim homeX As Int = dragshape.GethomeX
		Dim homeY As Int = dragshape.GethomeY
		
		Dim props As Map = CreateMap()
		props.Put("x", homeX)
		props.Put("y", homeY)
		game.Tween_Get(dragshape.Shape,False)
		game.tween_to3(props, 200, game.Ease_QuadOut)
	End If
End Sub

'inform user of score
Sub game_checkgame(e As BANanoEvent)
	If (score = 4) Then
		BANano.Alert("You won!")
	End If
End Sub

'object being dragged
Sub game_mousemove(e As BANanoEvent)
	Dim pt As CreateJSPoint = game.GetStagePoint(e)
	dragshape.SetX(pt.x)
	dragshape.SetY(pt.y)
End Sub