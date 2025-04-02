extends Control

@onready var overlay: Control = $Control
@onready var game: Node2D = $CharacterContact

func _on_button_pressed() -> void:
	overlay.visible = false
	game.start_game()
