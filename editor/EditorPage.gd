extends Control

signal close_clicked
@onready var scenario_scenector_node = $MarginContainer/ScenarioSelector
@onready var scenario_editor_node = $MarginContainer/ScenarioEditor
@onready var title_label_node = $TitleLabel
@onready var back_button_node = $BackButton

func show_scenario_selector() -> void:
	scenario_scenector_node.visible = true
	scenario_editor_node.visible = false
	back_button_node.visible = false
	
func show_scenario(scenario: Scenario) -> void:
	scenario_editor_node.scenario = scenario
	scenario_scenector_node.visible = false
	scenario_editor_node.visible = true
	title_label_node.text = "Edition\n" + scenario.name
	back_button_node.visible = true
	
func _ready() -> void:
	show_scenario_selector()

func _on_button_close_clicked() -> void:
	close_clicked.emit()
	show_scenario_selector()

func _on_scenario_selector_edit_scenario(uuid: String, scenario: Scenario) -> void:
	show_scenario(scenario)

func _on_back_button_pressed() -> void:
	show_scenario_selector()
