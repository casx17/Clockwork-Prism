extends Control

const BUTTON_SCENE = preload("uid://gxu4mg5hmti6")

@onready var vbox = $mainPanel/MarginContainer/VBoxContainer
@onready var anim = $anim

func _ready():
	DialogueManager.show_dialogue_choices.connect(_show_choices)
	
func _show_choices(choices : Array[String]) -> void:
	anim.play("start")
	
	if vbox.get_children():
		for i in vbox.get_children():
			i.queue_free()
	
	for i in choices:
		var temp_child = BUTTON_SCENE.instantiate()
		temp_child.text = i
		temp_child.connect("pressed", _button_pressed.bind(i))
		vbox.add_child(temp_child)
		
	vbox.get_child(0).grab_focus()
	print(get_viewport().gui_get_focus_owner())

func _button_pressed(response : String) -> void:
	DialogueManager.response_chosen.emit(response)
	anim.play("end")
