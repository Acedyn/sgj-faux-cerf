class_name HoveredWord
extends Control

@onready var current_target: Control = $DocumentContainer/IDTexture
@onready var character_speech: VBoxContainer = $CharacterSpeech
@onready var words_container: Control = $WordsContainer
@onready var result_container: Control = $ResultContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var levels: Array[Dictionary]
var current_level: Dictionary

func _ready() -> void:
	GlobalSignals.word_drag_in.connect(_on_word_drag_in)
	var levels_file = FileAccess.open("res://levels/levels.txt", FileAccess.READ)
	var entries = levels_file.get_csv_line()
	while !levels_file.eof_reached():
		var level = {}
		var level_data = levels_file.get_csv_line()
		if level_data.size() != entries.size():
			continue
		for i in range(entries.size()):
			var entry = entries[i]
			level[entry] = level_data[i]
			
		levels.append(level)
			
	select_level()
	
func _on_word_drag_in(node: SpeechWord):
	var duplicated_word = node.duplicate()
	duplicated_word.text = node.text.lstrip(",.!:?").rstrip(",.!:?")
	duplicated_word.state = SpeechWord.WordState.SELECTED
	duplicated_word.source = node
	node.state = SpeechWord.WordState.HIDDEN
	duplicated_word.doc_target = current_target.get_global_rect()
	words_container.add_child(duplicated_word)

func select_level():
	for child in words_container.get_children():
		child.queue_free()
		
	if current_level:
		character_speech.speech_text = ""
		animation_player.play("doc_animation_out")
		await animation_player.animation_finished
		animation_player.play("character_animation_out")
		await animation_player.animation_finished
		
	animation_player.play("character_animation_in")
	var level = levels[randi() % levels.size()]
	current_level = level
	await animation_player.animation_finished
	character_speech.speech_text = level["texte"]
	animation_player.play("doc_animation_in")


func compute_score(result: Dictionary):
	var score = 0
	for key in result:
		if key not in current_level:
			print("KEY " + key + " MISSING")
			score += 1
			continue
		if current_level[key] == result[key]:
			score += 1
			
	return float(score) / result.size()

func show_score(score: float):
	print("SCORE: " + str(score))
	result_container.visible = true
	if score > 0.5:
		animation_player.play("result_in_passed")
	else:
		animation_player.play("result_in_refused")
	await animation_player.animation_finished
	

func _on_validate_button_pressed() -> void:
	var children: Array[SpeechWord] = []
	for child in words_container.get_children():
		children.append(child)
	var score = compute_score(current_target.check_zones(children))
	show_score(score)
	
func hide_score():
	animation_player.play("result_out")
	await animation_player.animation_finished
	result_container.visible = false


func _on_continue_button_pressed() -> void:
	print("hello")
	await hide_score()
	select_level()
