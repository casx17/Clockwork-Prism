extends Control

@onready var character_image = $characterImage
@onready var graphic: ColorRect = $graphic
@onready var dialogue_label: RichTextLabel = $dialogueLabel
@onready var character_label = $characterLabel
@onready var letter_audio: AudioStreamPlayer = $letter_audio
@onready var anim = $anim
@onready var arrow: Sprite2D = $dialogueLabel/arrow

signal finished_sentence
signal accept_pressed
signal finished_dialogue

var sentence_skipped := false

func _ready() -> void:
	DialogueManager.connect("write_dialogue", _start_dialogue)
	#DialogueManager.startDialogue(load("res://resources/dialogue/test_dialogue.tres"))
	arrow.visible = false
	
func _start_dialogue(dialogue : Dialogue) -> void:
	if dialogue:
		anim.stop()
		anim.play("start")
		
		for i in dialogue.sentences:
			_start_writing(i)
			await finished_sentence
			if i.auto_continue:
				await get_tree().create_timer(i.auto_continue_time).timeout
			else:
				await accept_pressed
		_end_dialogue()
	else:
		printerr("tried to start dialogue with no dialogue file")

func _start_writing(sentence : Sentence) -> void:
	dialogue_label.visible_characters = 0
	dialogue_label.text = sentence.text
	letter_audio.stream = sentence.sound
	arrow.visible = false
	
	if sentence.speaker_sprite_frames:
		character_image.sprite_frames = sentence.speaker_sprite_frames
		if sentence.speaker_animation:
			character_image.play(sentence.speaker_animation)
		else:
			character_image.play("default")
	else:
		character_image.sprite_frames = null
		
	character_label.text = sentence.speaker_name
		
	sentence_skipped = false
	
	for i in sentence.text:
		if not sentence_skipped:
			dialogue_label.visible_characters += 1
			
			if not (i == " "):
				letter_audio.play()
			
			var wait_time = sentence.typewriter_speed
			if (i == ".") or (i == ",") or (i == "!") or (i == "?"):
				wait_time *= 1.2
			await get_tree().create_timer(wait_time).timeout
		else:
			break
		
	if not sentence_skipped:
		finished_sentence.emit()
		arrow.visible = true
		arrow.global_position = get_last_letter_position()
	
func _end_dialogue() -> void:
	anim.stop()
	anim.play("end")
	DialogueManager.dialogue_finished.emit()
	
func _clear_dialogue() -> void:
	dialogue_label.visible_characters = 0
	dialogue_label.text = ""
	letter_audio.stream = null

func _input(event):
	if event.is_action_pressed("dialogue_continue"):
		accept_pressed.emit()
	elif event.is_action_pressed("dialogue_skip"):
		sentence_skipped = true
		dialogue_label.visible_characters = len(dialogue_label.text)
		arrow.visible = true
		arrow.global_position = get_last_letter_position()
		finished_sentence.emit()

func get_last_letter_position():
	var text_server = TextServerManager.get_primary_interface()
	
	var paragraph = TextParagraph.new()
	paragraph.add_string(dialogue_label.text, dialogue_label.get_theme_font("normal_font"), dialogue_label.get_theme_font_size("normal_font_size"))
	paragraph.width = 300
	
	var x = 0.0
	var y = 0.0
	var ascent = 0.0
	var descent = 0.0

	for i in paragraph.get_line_count():
		x = 0.0
		
		ascent = paragraph.get_line_ascent(i)
		descent = paragraph.get_line_descent(i)

		var line_rid = paragraph.get_line_rid(i)
		var glyphs = text_server.shaped_text_get_glyphs(line_rid)

		for glyph in glyphs:
			var advance = glyph.get("advance", 0)
			var offset = glyph.get("offset", Vector2.ZERO)
			x += advance

		y += ascent + descent
	print(y)
	return Vector2(x + arrow.texture.get_width()/2, (dialogue_label.global_position.y + y/2) + 1)
