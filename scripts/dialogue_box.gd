extends Control

@onready var image: TextureRect = $image
@onready var graphic: ColorRect = $graphic
@onready var dialogue_label: RichTextLabel = $dialogueLabel
@onready var letter_audio: AudioStreamPlayer = $letter_audio

func _ready() -> void:
	_start_dialogue("hi what yeah hi. yeah im a pretty freakin cool guy. oh yeah.", load("res://audio/dialogue/placeholder_talk.mp3"))
	
func _start_dialogue(text : String, sound : AudioStream) -> void:
	dialogue_label.visible_characters = 0
	dialogue_label.text = text
	letter_audio.stream = sound
	
	for i in text:
		dialogue_label.visible_characters += 1
		letter_audio.pitch_scale = randf_range(0.95, 1.1)
		
		if not (i == " "):
			letter_audio.play()
		
		var wait_time = 0.04
		if (i == ".") or (i == ",") or (i == "!") or (i == "?"):
			wait_time += 0.3
		await get_tree().create_timer(wait_time).timeout
