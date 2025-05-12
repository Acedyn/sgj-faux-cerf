extends Control

@export var scenario: Scenario:
	set(value):
		scenario = value
		load_event_entries()
		scenario.events_updated.connect(load_event_entries)
		
var event_entry_scene = preload("res://editor/EventEntry.tscn")
@onready var event_container = $EventsScroll/EventsContainer
@onready var event_dropdown = $EventDropdown
var event_dropdown_initial_position = Vector2.ZERO

func _ready() -> void:
	event_dropdown_initial_position = event_dropdown.position
	event_dropdown.visible = false
	
	if scenario:
		load_event_entries()

func show_new_event_dropdown(index: int) -> void:
	event_dropdown.position.y = self.size.y
	event_dropdown.visible = true
	event_dropdown.initial_index = index
	event_dropdown.scenario = scenario
	var scenario_dropdown_tween = get_tree().create_tween()
	var property_tweener = scenario_dropdown_tween.tween_property(
		event_dropdown,
		"position",
		event_dropdown_initial_position,
		0.2
	)
	property_tweener.set_trans(Tween.TRANS_QUINT)
	property_tweener.set_ease(Tween.EASE_OUT)
	await property_tweener.finished
	
func load_event_entries():
	# Clear the existing entries
	for event_entry in event_container.get_children():
		event_entry.queue_free()
	# Create a new entry for each event in the event store
	for event_index in range(scenario.events.size()):
		var event = scenario.events[event_index]
		var event_entry = event_entry_scene.instantiate()
		event_entry.event = event
		event_entry.index = event_index
		event_entry.add_event.connect(show_new_event_dropdown)
		event_container.add_child(event_entry)

func _on_add_button_pressed() -> void:
	show_new_event_dropdown(0)
