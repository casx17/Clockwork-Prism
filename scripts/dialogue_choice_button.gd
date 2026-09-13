extends Button

var scale_tween : Tween

func _ready() -> void:
	mouse_entered.connect(_hover)
	focus_entered.connect(_hover)
	mouse_exited.connect(_unhover)
	focus_exited.connect(_unhover)
	
func _hover() -> void:
	if scale_tween and is_instance_valid(scale_tween): scale_tween.kill()
	scale_tween = create_tween()
	scale_tween.set_parallel(true)
	scale_tween.set_ease(Tween.EASE_OUT)
	scale_tween.set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 1.2)
	scale_tween.tween_property(self, "custom_minimum_size:y", 42.0, 1.1)

func _unhover() -> void:
	if scale_tween and is_instance_valid(scale_tween): scale_tween.kill()
	scale_tween = create_tween()
	scale_tween.set_parallel(true)
	scale_tween.set_ease(Tween.EASE_OUT)
	scale_tween.set_trans(Tween.TRANS_EXPO)
	scale_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
	scale_tween.tween_property(self, "custom_minimum_size:y", 30.0, 1.1)
