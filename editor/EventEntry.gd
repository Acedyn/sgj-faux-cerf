extends Button

signal add_event(index: int)
@onready var index_node: Label = $Panel/ButtonMargin/LabelsContainer/TitleContainer/Index
@onready var title_node: Label = $Panel/ButtonMargin/LabelsContainer/TitleContainer/Title
@onready var event_type_node: Label = $Panel/ButtonMargin/LabelsContainer/HBoxContainer/EventTypeLabel

@export var index: int = 0:
	set(value):
		if index_node:
			index_node.text = str(value) + "."
		index = value
@export var event: ScenarioEvent:
	set(value):
		if title_node:
			title_node.text = value.name
			event_type_node.text = value.type_name
		event = value

func _ready() -> void:
	title_node.text = event.name
	event_type_node.text = event.type_name
	index_node.text = str(index) + "."

func _on_add_button_pressed() -> void:
	add_event.emit(index+1)
