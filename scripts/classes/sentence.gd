class_name Sentence extends Resource

@export_category("data")
@export_multiline var text : String
@export var auto_continue : bool = false
@export var auto_continue_time : float

@export_category("elements")
@export var typewriter_speed : float = 0.04
@export var speaker_name : String
@export var speaker_sprite_frames : SpriteFrames
@export var speaker_animation : String
@export var sound : AudioStream
