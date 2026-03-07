extends Node3D

@onready var switch_timer: Timer = $"../../../switch_timer"

var s : float = 0.0
var rotation_y_add : float = 0.0
var target_rotation_y : float = 0.0
var rotation_offset := Vector3(0, 0, 0)
var rotation_tween : Tween
const curve = preload("uid://dhpq2bmtlvbpq")

func _physics_process(delta: float) -> void:
	s += 0.1
	
	rotation_offset = Vector3(cos(s * 0.3) * 0.019, sin(s * 0.2) * 0.012, sin(s * 0.24) * 0.009)

	rotation = Vector3(rotation_offset.x, target_rotation_y + rotation_offset.y, rotation_offset.z)

	if Input.is_action_just_pressed("ui_left") and switch_timer.is_stopped():
		rotation_y_add += 120
		_tween_rotation()
		switch_timer.start()
	elif Input.is_action_just_pressed("ui_right") and switch_timer.is_stopped():
		rotation_y_add -= 120
		_tween_rotation()
		switch_timer.start()
		
func _tween_rotation() -> void:
	if rotation_tween and is_instance_valid(rotation_tween):
		rotation_tween.kill()
		
	rotation_tween = create_tween()
	
	rotation_tween.tween_property(self, "target_rotation_y", deg_to_rad(rotation_y_add), 0.6).set_custom_interpolator(_tween_curve)

func _tween_curve(v):
	return curve.sample_baked(v)
