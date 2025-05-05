class_name Scenario
extends Resource

@export var name: String = "Untitled"
@export var author: String = "Unknown"
@export var events: Array[ScenarioEvent] = []

func _init(p_name: String = "Untitled", p_author: String = "Unknown", p_events: Array[ScenarioEvent] = []):
	name = p_name
	author = p_author
	events = p_events
