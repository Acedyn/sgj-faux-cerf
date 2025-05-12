extends Control

@onready var event_name_node: LineEdit = $MarginContainer/VBoxContainer/EventNameContainer/EventNameInput/LineEdit
@onready var event_index_node: SpinBox = $MarginContainer/VBoxContainer/EventNameContainer/EventIndexInput
@onready var event_type_node: OptionButton = $MarginContainer/VBoxContainer/EventTypeContainer/EventTypeOption
@onready var event_settings: Array[EventSettings] = [
	$MarginContainer/VBoxContainer/DefaultSettings,
	$MarginContainer/VBoxContainer/NewsSettings,
	$MarginContainer/VBoxContainer/ClientSettings,
]
@export var selected_event_settings: EventSettings
@export var scenario: Scenario
@export var initial_index: int = 0:
	set(value):
		if event_index_node:
			event_index_node.value = value
		initial_index = value
		
func _ready() -> void:
	event_index_node.value = initial_index
	select_event_settings("default")
	
func select_event_settings(event_type: String):
	for current_event_settings in event_settings:
		if current_event_settings.get_event_type() == event_type:
			current_event_settings.visible = true
			selected_event_settings = current_event_settings
		else:
			current_event_settings.visible = false
			current_event_settings.reset()
		
func hide_new_event_dropdown() -> void:
	var event_dropdown_tween = get_tree().create_tween()
	var property_tweener = event_dropdown_tween.tween_property(
		self,
		"position",
		Vector2(position.x, get_parent().size.y),
		0.2
	)
	property_tweener.set_trans(Tween.TRANS_QUINT)
	property_tweener.set_ease(Tween.EASE_IN)
	await property_tweener.finished
	self.visible = false
	event_name_node.text = ""
	event_index_node.value = 0
	
func _on_event_type_option_item_selected(index: int) -> void:
	select_event_settings(event_type_node.get_item_text(index))

func _on_close_event_button_pressed() -> void:
	hide_new_event_dropdown()

func _on_confirm_event_button_pressed() -> void:
	var event_name = event_name_node.text
	if event_name_node.text == "":
		event_name = event_name_node.placeholder_text
	
	var new_event = selected_event_settings.build_event(event_name)
	var new_event_list: Array[ScenarioEvent] = []
	for event_index in range(scenario.events.size()):
		var current_event = scenario.events[event_index]
		if event_index == event_index_node.value:
			new_event_list.push_back(new_event)
		new_event_list.push_back(current_event)
	if event_index_node.value == scenario.events.size():
			new_event_list.push_back(new_event)
	scenario.events = new_event_list
		
	hide_new_event_dropdown()
	selected_event_settings.reset()
