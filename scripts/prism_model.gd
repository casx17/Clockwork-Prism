extends Node3D

const curve = preload("uid://dhpq2bmtlvbpq")

var s : float = 0.0
var rotation_y_add : float = 0.0
var target_rotation_y : float = 0.0
var rotation_offset := Vector3(0, 0, 0)
var rotation_tween : Tween

func _physics_process(delta: float) -> void:
	s += 0.1
	
	rotation_offset = Vector3(cos(s * 0.3) * 0.019, sin(s * 0.2) * 0.012, sin(s * 0.24) * 0.009)

	rotation = Vector3(rotation_offset.x, target_rotation_y + rotation_offset.y, rotation_offset.z)
	
func turn(direction : int) -> void:
	if direction >= 0:
		rotation_y_add -= 120
	else:
		rotation_y_add += 120
	_tween_rotation()

func _tween_rotation() -> void:
	if rotation_tween and is_instance_valid(rotation_tween):
		rotation_tween.kill()
		
	rotation_tween = create_tween()
	
	rotation_tween.tween_property(self, "target_rotation_y", deg_to_rad(rotation_y_add), 0.5).set_custom_interpolator(_tween_curve)

func _tween_curve(v):
	return curve.sample_baked(v)
