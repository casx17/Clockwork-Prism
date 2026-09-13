extends Control

@onready var viewport_container = $viewportContainer

func _ready() -> void:
	get_window().size_changed.connect(_resize)
	_resize()
	
func _resize() -> void:
	var new_size: Vector2 = get_window().size
	var scale_x = new_size.x / size.x
	var scale_y = new_size.y / size.y
	
	var chosen_scale = min(scale_x, scale_y)
	
	scale = Vector2.ONE * chosen_scale
