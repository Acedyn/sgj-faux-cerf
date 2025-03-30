class_name HoveredWord
extends Control

@onready var current_target: Control = $DocumentContainer/IDTexture
@onready var character_speech: VBoxContainer = $CharacterSpeech
@onready var words_container: Control = $WordsContainer
@onready var result_container: Control = $ResultContainer
@onready var manchette_container: ManchetteContainer = $ManchetteContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var levels: Array[Dictionary]
var current_level: Dictionary
var level_number = 0;

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
	# Clear the writted words
	for child in words_container.get_children():
		child.queue_free()
		
	# If there is a level already loaded, clear it
	if current_level:
		character_speech.speech_text = ""
		animation_player.play("doc_animation_out")
		await animation_player.animation_finished
		animation_player.play("character_animation_out")
		await animation_player.animation_finished
		
	# Show a manchette every 3 levels
	if level_number % 3 == 0:
		await manchette_container.show_next_manchette()
		
	# Start the next level
	animation_player.play("character_animation_in")
	var level = levels[randi() % levels.size()]
	current_level = level
	level_number += 1
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
	

func _on_validate_button_pressed() -> void:
	var children: Array[SpeechWord] = []
	for child in words_container.get_children():
		children.append(child)
	var score = compute_score(current_target.check_zones(children))
	await result_container.show_score(score)


func _on_continue_button_pressed() -> void:
	await result_container.hide_score()
	select_level()
