extends Control

@onready var vbox = $Panel/MarginContainer/VBoxContainer
const BUTTON_SCENE = preload("uid://gxu4mg5hmti6")

func _ready():
	DialogueManager.showDialogueChoices.connect(_show_choices)
	
func _show_choices(choices : Array[String]) -> void:
	for i in choices:
		var temp_child = BUTTON_SCENE.instantiate()
		temp_child.text = i
		vbox.add_child(temp_child)
