extends SpringArm3D

@export var target : Node3D

func _physics_process(delta):
	if target and is_instance_valid(target):
		global_position.x = lerp(global_position.x, target.global_position.x, delta * 10)
		global_position.y = lerp(global_position.y, target.global_position.y, delta * 5)
		global_position.z = lerp(global_position.z, target.global_position.z, delta * 10)
