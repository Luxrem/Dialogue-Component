extends Node
## Dialogue script used to start, go through and update dialogue display.
## The script allows to use BBCode from structured JSON dialogue files to
## apply styles to the dialogue window. Dialogue is also writen out to make
## it more appealing.

@onready var label = $CanvasLayer/RichTextLabel
@onready var nextLineButton = $CanvasLayer/Button
@onready var canvasLayer = $CanvasLayer
@onready var choicesContainer = $CanvasLayer/ChoicesContainer
@onready var typeTimer = $CanvasLayer/TypeTimer

var key = "dialogue_start" ## dialogue sentence key variable
var dialogue_data = {} ## dialogue data dictionary variable
var full_text = "" ## sentence text variable
var full_bbcode_text = "" ## sentence text variable with BBCode notation
var char_index = 0 ## character index variable used for typing logic

## Funcition used to determine and get the visability of the dialogue canvas
func state(): 
	var visibility = canvasLayer.visible ## canvas visibility variable
	return visibility
	
## Function used to hide the dialogue canvas
func close():
	canvasLayer.hide()
	
## Function used to show the dialogue canvas
func open():
	canvasLayer.show()

## Function used to start the dialogue:
## The function read the dialogue file and sets its data.
## Then the dialogue key is set to dialogue start and the update_dialogue_display
## function is called. A button is connected to the next_line funtiona and the
## open function is called to show the dialogue canvas.
func start_dialogue(path):
	#was_not_choice = true
	var dialogue_text = FileAccess.open(path, FileAccess.READ).get_as_text()
	var _dialogue_data = JSON.parse_string(dialogue_text)
	dialogue_data = _dialogue_data
	
	key = "dialogue_start"
	update_dialogue_display(key)
	if not nextLineButton.pressed.is_connected(next_line):
		nextLineButton.pressed.connect(next_line)
	open()

## Function used to update the dialogue display.
func update_dialogue_display(key):
	nextLineButton.show()
	for child in choicesContainer.get_children():
		child.queue_free()
	if key == "dialogue_end":
		close()
		return
	if "choices" in dialogue_data[key]:
		nextLineButton.hide()
		for choice in dialogue_data[key]["choices"]:
			var button = Button.new()
			button.text = choice["text"]
			button.pressed.connect(pick_dialogue_choice.bind(choice))
			choicesContainer.add_child(button)
	#label.text = dialogue_data[key]["text"]
	start_typing(dialogue_data[key]["text"], dialogue_data[key]["bbcode"])
	#typeTimer.start()

## Function used to pick a dialogue choice
func pick_dialogue_choice(choice):
	key = choice["goto"]
	update_dialogue_display(key)

## Function used to go to the next sentence in a dialogue
func next_line():
	key = dialogue_data[key]["goto"]
	update_dialogue_display(key)

## Function that starts the timer
func start_typing(text, bbcode):
	full_text = text
	full_bbcode_text = bbcode
	char_index = 0
	label.text = ""
	typeTimer.start()

## Function used by the timer to type out the text
func _on_TypeTimer_timeout():
	label.text += full_text[char_index]
	char_index += 1
	if char_index >= full_text.length():
		typeTimer.stop()
		label.text = full_bbcode_text

func _ready() -> void:
	typeTimer.timeout.connect(_on_TypeTimer_timeout)
	pass
