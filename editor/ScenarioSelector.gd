extends Control

# TODO: Rename this signal to scenario_pressed
signal edit_scenario(uuid: String, scenario: Scenario)
var scenario_entry_scene = preload("res://editor/ScenarioEntry.tscn")
@onready var scenario_container = $ScenariosScroll/ScenarioContainer
@onready var scenario_dropdown = $NewScenarioDropdown
@onready var new_scenario_button = $NewScenarioButton
@export var show_new_scenario_button: bool = true
var scenario_dropdown_initial_position = Vector2.ZERO

func _ready() -> void:
	# Make sure the new scenario drop down of off by default
	scenario_dropdown.visible = false
	scenario_dropdown_initial_position = scenario_dropdown.position
	load_scenario_entries()
	ScenarioStore.scenarios_updated.connect(load_scenario_entries)
	if not show_new_scenario_button:
		new_scenario_button.visible = false
	
func load_scenario_entries():
	# Clear the existing entries
	for scenario_entry in scenario_container.get_children():
		scenario_entry.queue_free()
	# Create a new entry for each scenario in the scenario store
	for scenario_uuid in ScenarioStore.scenarios.keys():
		var scenario = ScenarioStore.scenarios[scenario_uuid]
		var scenario_entry: Button = scenario_entry_scene.instantiate()
		scenario_entry.scenario = scenario
		scenario_entry.uuid = scenario_uuid
		scenario_container.add_child(scenario_entry)
		scenario_entry.pressed.connect(func ():
			edit_scenario.emit(scenario_uuid, scenario)
		)

func _on_new_scenario_pressed() -> void:
	scenario_dropdown.position.y = self.size.y
	scenario_dropdown.visible = true
	var scenario_dropdown_tween = get_tree().create_tween()
	var property_tweener = scenario_dropdown_tween.tween_property(
		scenario_dropdown,
		"position",
		scenario_dropdown_initial_position,
		0.2
	)
	property_tweener.set_trans(Tween.TRANS_QUINT)
	property_tweener.set_ease(Tween.EASE_OUT)
	await property_tweener.finished
