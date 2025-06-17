extends Control

signal close_clicked
@onready var scenario_scenector_node: Control = $MarginContainer/ScenarioSelector
@onready var scenario_player_node: ScenarioPlayer = $MarginContainer/ScenarioPlayer

func show_scenario_selector() -> void:
	scenario_scenector_node.visible = true
	scenario_player_node.visible = false
	
func show_game(scenario: Scenario) -> void:
	scenario_player_node.visible = true
	scenario_scenector_node.visible = false
	scenario_player_node.scenario = scenario
	scenario_player_node.play_next_event()
	
func _ready() -> void:
	show_scenario_selector()

func _on_button_close_clicked():
	close_clicked.emit()
	show_scenario_selector()

func _on_scenario_selector_edit_scenario(uuid, scenario):
	show_game(scenario)
