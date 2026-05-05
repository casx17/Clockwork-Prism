class_name Player extends CharacterBody3D

@onready var interaction_radius = $interaction_radius
@onready var interact_label: Node3D = $interactLabel
@onready var interact_anim: AnimationPlayer = $interactLabel/interactAnim

var speed := 1.9
var acceleration := 13.0
var friction := 20.0
var gravity := 17.0
var interaction_area : InteractionArea = null

func _physics_process(delta: float) -> void:
	if not PlayerManager.interacting:
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

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if interaction_area and not PlayerManager.interacting:
			interaction_area.interacted_with.emit()

func _on_interaction_radius_area_entered(area : Area3D):
	if area is InteractionArea:
		interaction_area = area
		interact_label.visible = true
		interact_anim.play("go")
		
func _on_interaction_radius_area_exited(_area : Area3D):
	if not interaction_radius.get_overlapping_areas():
		interaction_area = null
		interact_label.visible = false
		interact_anim.stop()
