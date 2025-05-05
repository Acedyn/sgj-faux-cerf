extends Control

var scenario_entry_scene = preload("res://editor/ScenarioEntry.tscn")
@onready var scenario_container = $ScenariosScroll/ScenarioContainer

func _ready() -> void:
	load_scenario_entries()
	ScenarioStore.scenarios_updated.connect(load_scenario_entries)
	
func load_scenario_entries():
	# Clear the existing entries
	for scenario_entry in scenario_container.get_children():
		scenario_entry.queue_free()
	# Create a new entry for each scenario in the scenario store
	for scenario in ScenarioStore.scenarios.values():
		var scenario_entry = scenario_entry_scene.instantiate()
		scenario_entry.title = scenario.name
		scenario_entry.event_count = scenario.events.size()
		scenario_entry.author = scenario.author
		scenario_container.add_child(scenario_entry)

func _on_new_scenario_pressed() -> void:
	pass # Replace with function body.
