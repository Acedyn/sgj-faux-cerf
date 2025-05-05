class_name NewsEvent
extends ScenarioEvent

@export var title: String = "Untitled"
@export var paragraphs: Array[String] = []

func _init(p_name: String = "Untitled", p_title: String = "Untitled", p_paragraphs: Array[String] = []):
	super._init(p_name, "news")
	title = p_title
	paragraphs = p_paragraphs
