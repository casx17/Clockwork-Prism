class_name Npc extends Node3D

@export var interaction_area : InteractionArea

func _ready():
	if interaction_area:
		interaction_area.connect("interacted_with", interact)
	DialogueManager.connect("response_chosen", _receive_response)

func interact() -> void:
	PlayerManager.interaction_target = self

func _receive_response(response : String) -> void:
	pass
