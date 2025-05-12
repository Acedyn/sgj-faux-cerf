class_name EventSettings
extends Node

func get_event_type() -> String:
	return ""

func build_event(event_name: String) -> ScenarioEvent:
	return ScenarioEvent.new(event_name)

func reset() -> void:
	pass
