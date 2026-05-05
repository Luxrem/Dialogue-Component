extends Control

@onready var dialogue_choices = $DialogueChoices
@onready var dialogue_1 = $DialogueChoices/dialogue_1
@onready var dialogue_2 = $DialogueChoices/dialogue_2
@onready var dialogue_manager = $DialogueManager



func start_dialogue(path):
	dialogue_choices.hide()
	dialogue_manager.start_dialogue(path)
	#dialogue_choices.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	dialogue_manager.close()
	dialogue_1.pressed.connect(start_dialogue.bind("res://dialogues/test_dialogue.json"))
	dialogue_2.pressed.connect(start_dialogue.bind("res://dialogues/dialogue_2.json"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!dialogue_manager.state()):
		dialogue_choices.show()
	pass
