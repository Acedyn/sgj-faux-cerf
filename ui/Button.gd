@tool
extends Control

@onready var label_node: Label = $MarginContainer/MainLabel
@onready var button_node: TextureButton = $ButtonBase
signal clicked

@export
var label_value: String = "Button":
	set(value):
		# The label node might not be ready yet
		if label_node:
			label_node.text = value
		label_value = value

func _ready():
	# The label node might not exist since this script
	# is meant to be used for multiple types of buttons
	if label_node:
		label_node.text = label_value
	button_node.pressed.connect(_on_button_base_pressed)

func _on_button_base_pressed() -> void:
	clicked.emit()
