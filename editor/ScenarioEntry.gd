extends Button

@onready var title_node: Label = $Panel/ButtonMargin/LabelsContainer/Title
@onready var event_count_node: Label = $Panel/ButtonMargin/LabelsContainer/HBoxContainer/EventsCount
@onready var author_node: Label = $Panel/ButtonMargin/LabelsContainer/HBoxContainer/Author

@export var uuid: String = ""
@export var scenario: Scenario:
	set(value):
		if title_node:
			title_node.text = value.name
			event_count_node.text = str(value.events.size())
			author_node.text = value.author
		scenario = value

func _ready() -> void:
	title_node.text = scenario.name
	event_count_node.text = str(scenario.events.size())
	author_node.text = scenario.author
