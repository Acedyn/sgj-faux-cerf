class_name SpeechWord
extends Button

enum WordState {IN_SPEECH, HIDDEN, SELECTED, PLACED}
@export var state: WordState:
	set(value):
		if value == WordState.HIDDEN:
			modulate = Color(0, 0, 0, 0)
		else:
			modulate = Color(1, 1, 1, 1)
		state = value
		
		if value == WordState.PLACED:
			var flat := StyleBoxFlat.new()
			flat.bg_color = Color(1, 1, 1, 1)
			flat.corner_radius_bottom_left = 5
			flat.corner_radius_bottom_right = 5
			flat.corner_radius_top_left = 5
			flat.corner_radius_top_right = 5
			add_theme_stylebox_override("normal", flat)
			add_theme_stylebox_override("hover", flat)
			add_theme_stylebox_override("hover_pressed", flat)
			add_theme_stylebox_override("focus", flat)
			add_theme_stylebox_override("pressed", flat)
@export var hovered: bool = false
@export var offset: Vector2 = Vector2(0, 0)
@export var doc_target: Rect2 = Rect2()
@export var source: SpeechWord

func _on_button_down() -> void:
	offset = global_position - get_global_mouse_position()
	if state == WordState.IN_SPEECH:
		GlobalSignals.word_drag_in.emit(self)
	elif  state == WordState.PLACED:
		state = WordState.SELECTED

func _process(delta: float) -> void:
	if state == WordState.SELECTED:
		if not Input.is_mouse_button_pressed(1):
			if doc_target.intersects(get_rect()):
				state = WordState.PLACED
			else:
				if source:
					source.state = WordState.IN_SPEECH
				queue_free()
		else:
			global_position = get_global_mouse_position() + offset
