class_name SpeechWord
extends Button

enum WordState {IN_SPEECH, SELECTED, PLACED}
@export var state: WordState
@export var hovered: bool = false

func _on_button_down() -> void:
	add_theme_color_override("font_color", Color(0, 0, 0, ))
	GlobalSignals.word_drag_in.emit(self)

func _process(delta: float) -> void:
	if state == WordState.SELECTED:
		if not Input.is_mouse_button_pressed(1):
			state = WordState.PLACED
		global_position = get_global_mouse_position()
