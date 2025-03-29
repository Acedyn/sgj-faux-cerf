class_name SpeechWord
extends Button

enum WordState {IN_SPEECH, SELECTED, PLACED}
@export var state: WordState
@export var hovered: bool = false
@export var offset: Vector2 = Vector2(0, 0)
@export var target: Rect2 = Rect2()

func _on_button_down() -> void:
	offset = global_position - get_global_mouse_position()
	if state == WordState.IN_SPEECH:
		GlobalSignals.word_drag_in.emit(self)
	elif  state == WordState.PLACED:
		state = WordState.SELECTED

func _process(delta: float) -> void:
	if state == WordState.SELECTED:
		if not Input.is_mouse_button_pressed(1):
			if target.intersects(get_rect()):
				state = WordState.PLACED
			else:
				queue_free()
		else:
			global_position = get_global_mouse_position() + offset
