class_name Player extends CharacterBody3D

var speed := 1.9
var acceleration := 13.0
var friction := 20.0
var gravity := 17.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y * 0.85)).normalized()
	
	var vel_weight : float 
	vel_weight = (acceleration if direction.x else friction) * delta
	velocity.x = lerp(velocity.x, direction.x * speed, vel_weight)
	vel_weight = (acceleration if direction.z else friction) * delta
	velocity.z = lerp(velocity.z, direction.z * speed, vel_weight)

	move_and_slide()
