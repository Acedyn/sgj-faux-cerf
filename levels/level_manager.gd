class_name HoveredWord
extends Control

@onready var current_target: Control = $DocumentContainer/IDTexture
@onready var character_speech: VBoxContainer = $CharacterSpeech
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
	duplicated_word.text = node.text
	duplicated_word.state = SpeechWord.WordState.SELECTED
	duplicated_word.target = current_target.get_global_rect()
	add_child(duplicated_word)

func select_level():
	if current_level:
		animation_player.play("doc_animation_out")
		await animation_player.animation_finished
		animation_player.play("character_animation_out")
		
	animation_player.play("character_animation_in")
	var level = levels[randi() % levels.size()]
	await animation_player.animation_finished
	character_speech.speech_text = level["texte"]
	animation_player.play("doc_animation_in")
