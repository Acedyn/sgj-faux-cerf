class_name HoveredWord
extends Control

@onready var current_level: Control = $IDTexture

func _ready() -> void:
	GlobalSignals.word_drag_in.connect(_on_word_drag_in)
	
func _on_word_drag_in(node: SpeechWord):
	var duplicated_word = node.duplicate()
	duplicated_word.text = node.text
	duplicated_word.state = SpeechWord.WordState.SELECTED
	duplicated_word.target = current_level.get_global_rect()
	add_child(duplicated_word)
