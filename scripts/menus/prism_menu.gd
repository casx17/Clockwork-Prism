extends Control

@onready var paper_prism = $prismViewport/Node3D/paperPrism

@onready var anim = $AnimationPlayer
@onready var switch_timer = $switchTimer
@onready var open_timer = $openTimer

var open := false

func _input(event):
	if event.is_action_pressed("use_prism") and open_timer.is_stopped():
		open = not open
		open_timer.start()
		if open:
			anim.play("open")
		else:
			anim.play("close")

	if event.is_action_pressed("turn_prism_left") and switch_timer.is_stopped():
		paper_prism.turn(-1)
		switch_timer.start()
	elif event.is_action_pressed("turn_prism_right") and switch_timer.is_stopped():
		paper_prism.turn(1)
		switch_timer.start()
