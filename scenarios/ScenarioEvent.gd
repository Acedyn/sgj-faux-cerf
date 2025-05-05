class_name ScenarioEvent
extends Resource

@export var name: String = "Untitled"
@export var type_name: String = "Untyped"

func _init(p_name: String = "Untitled", p_type_name: String = "Untyped"):
	name = p_name
	type_name = p_type_name
