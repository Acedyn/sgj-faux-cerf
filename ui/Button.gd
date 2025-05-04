@tool
extends Control

@onready var label_node: Label = $MarginContainer/MainLabel

@export
var label_value: String = "Button":
	set(value):
		label_node.text = value
		label_value = value
