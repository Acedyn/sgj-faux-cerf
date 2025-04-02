class_name ProspectusContainer
extends Control

@onready var button_container: Control = $ProspectusButtons
@onready var selected_container: Control = $ProspectusSelected

func create_prospectus_buttons(indexes: Array[int]):
	for child in button_container.get_children():
		var tween = get_tree().create_tween()
		await tween.tween_property(child, "modulate:a", 0, 0.1).finished
		child.queue_free()
		
	for child in selected_container.get_children():
		var tween = get_tree().create_tween()
		await tween.tween_property(child, "modulate:a", 0, 0.1).finished
		child.queue_free()
		
	for index in indexes:
		var scene_path = "res://prospectus/scenes/" + str(index) + ".tscn"
		var scene = load(scene_path)
		if not scene:
			print("ERROR: Prospectus " + str(index) + " not implemented")
			continue
			
		var node = scene.instantiate()
		node.name = str(index)
		button_container.modulate.a = 0
		button_container.add_child(node)
		var tween = get_tree().create_tween()
		await tween.tween_property(button_container, "modulate:a", 1, 0.1).finished
		await on_prospectus_pressed(node)
		node.Pressed.connect(on_prospectus_pressed)

func on_prospectus_pressed(node):
	if selected_container.get_children().size() > 0:
		for child in selected_container.get_children():
			var tween = get_tree().create_tween()
			await tween.tween_property(child, "modulate:a", 0, 0.1).finished
			child.queue_free()
		return
		
	var scene_path = "res://prospectus/item_scene/" + node.name + ".tscn"
	var scene = load(scene_path)
	if not scene:
		print("ERROR: Prospectus " + node.name + " not implemented")
		return
		
	var tween = get_tree().create_tween()
	var new_node: Control = scene.instantiate()
	new_node.modulate.a = 0
	selected_container.add_child(new_node)
	await tween.tween_property(new_node, "modulate:a", 1, 0.1).finished
