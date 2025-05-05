extends TextureButton

@onready var title_node: Label = $Panel/ButtonMargin/LabelsContainer/Title
@onready var event_count_node: Label = $Panel/ButtonMargin/LabelsContainer/HBoxContainer/EventsCount
@onready var author_node: Label = $Panel/ButtonMargin/LabelsContainer/HBoxContainer/Author

@export var title: String = "Untitled":
	set(value):
		if title_node:
			title_node.text = value
		title = value
@export var event_count: int = 0:
	set(value):
		if title_node:
			event_count_node.text = str(value)
		event_count = value
@export var author: String = "Unknown":
	set(value):
		if title_node:
			title_node.text = value
		author = value

func _ready() -> void:
	title_node.text = title
	event_count_node.text = str(event_count)
	author_node.text = author
