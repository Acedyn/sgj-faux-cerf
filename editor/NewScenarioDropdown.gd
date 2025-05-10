extends Control

@onready var scenario_name_node = $MarginContainer/VBoxContainer/ScenarioNameInput/LineEdit
@onready var scenario_author_node = $MarginContainer/VBoxContainer/ScenarioAuthor/LineEdit

func hide_new_scenario_dropdown() -> void:
	var scenario_dropdown_tween = get_tree().create_tween()
	var property_tweener = scenario_dropdown_tween.tween_property(
		self,
		"position",
		Vector2(position.x, get_parent().size.y),
		0.2
	)
	property_tweener.set_trans(Tween.TRANS_QUINT)
	property_tweener.set_ease(Tween.EASE_IN)
	await property_tweener.finished
	self.visible = false
	scenario_name_node.text = ""
	scenario_author_node.text = ""

func _on_close_scenario_button_pressed() -> void:
	hide_new_scenario_dropdown()

func _on_confirm_scenario_button_pressed() -> void:
	var scenario_name = scenario_name_node.text
	if scenario_name_node.text == "":
		scenario_name = scenario_name_node.placeholder_text
	var scenario_author = scenario_author_node.text
	if scenario_author_node.text == "":
		scenario_author = scenario_author_node.placeholder_text
		
	# Create a blank scenario from the input values
	var new_scenario = Scenario.new(
		scenario_name,
		scenario_author
	)

	# Register the new scernario to the scenario global store
	ScenarioStore.scenarios = ScenarioStore.scenarios.merged({
		UUID.v7(): new_scenario
	})
	
	hide_new_scenario_dropdown()
