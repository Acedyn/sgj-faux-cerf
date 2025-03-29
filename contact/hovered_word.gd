class_name HoveredWord
extends Control

func _ready() -> void:
	GlobalSignals.word_drag_in.connect(_on_word_drag_in)
	
func _on_word_drag_in(node: SpeechWord):
	var duplicated_word = node.duplicate()
	duplicated_word.name = node.name + "_REPARENTED"
	duplicated_word.text = node.text
	duplicated_word.hovered = true
	duplicated_word.state = SpeechWord.WordState.SELECTED
	add_child(duplicated_word)
