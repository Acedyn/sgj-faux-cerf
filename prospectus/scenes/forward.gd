extends Control

signal Pressed
@onready var button: TextureButton = $TextureRect

func _ready() -> void:
	button.pressed.connect(on_pressed)
	
func on_pressed():
	emit_signal("Pressed", self)
