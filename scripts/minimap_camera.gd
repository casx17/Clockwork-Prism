extends Camera3D

@export var target : Node3D

func _physics_process(delta):
	if target and is_instance_valid(target):
		global_position = Vector3(target.global_position.x, 40, target.global_position.z)
