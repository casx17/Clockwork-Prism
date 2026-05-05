extends Node

signal show_dialogue_choices(choices : Array[String])
signal write_dialogue(dialogue : Dialogue)
signal dialogue_finished
signal response_chosen(response : String)

var in_dialogue := false

func _ready() -> void:
	dialogue_finished.connect(_dialogue_finished)

func startDialogue(dialogue : Dialogue) -> void:
	in_dialogue = true
	write_dialogue.emit(dialogue)

func promptDialogueChoices(choices : Array[String]) -> void:
	show_dialogue_choices.emit(choices)

func _dialogue_finished() -> void:
	in_dialogue = false
