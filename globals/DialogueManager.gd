extends Node

signal showDialogueChoices(choices : Array[String])

func promptDialogueChoices(choices : Array[String]) -> void:
	showDialogueChoices.emit(choices)

func _ready():
	await get_tree().create_timer(0.5).timeout
	promptDialogueChoices(["yeah", "nah", "shut up", "what"])
