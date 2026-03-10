extends Node3D

@onready var anim = $AnimationPlayer
@onready var label = $SubViewport/Control/RichTextLabel

func open() -> void:
	anim.play("open")
	
func close() -> void:
	anim.play("close")
