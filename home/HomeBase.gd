extends Control

@onready var menu_page_node: Control = $MenuPage
@onready var editor_page_node: Control = $EditorPage
@onready var credits_page_node: Control = $CreditsPage

var current_page_node: Control

func _ready() -> void:
	# Make sure every pages are hidden
	menu_page_node.visible = false
	editor_page_node.visible = false
	credits_page_node.visible = false
	
	# The default page is the menu
	show_menu_page()
	
func hide_page(node: Control):
	# Animate the opacity of the given page to hide it
	var modulate_tween = get_tree().create_tween()
	await modulate_tween.tween_property(
		node,
		"modulate",
		Color(1, 1, 1, 0),
		0.1
	).finished
	node.visible = false
	
func show_page(node: Control):
	# Animate the opacity of the given page to show it
	node.visible = true
	var modulate_tween = get_tree().create_tween()
	await modulate_tween.tween_property(
		node,
		"modulate",
		Color(1, 1, 1, 1),
		0.2
	).finished

func show_menu_page():
	# Replace the current page with the menu page
	if current_page_node:
		hide_page(current_page_node)
	show_page(menu_page_node)
	current_page_node = menu_page_node

func show_editor_page():
	# Replace the current page with the editor page
	if current_page_node:
		hide_page(current_page_node)
	show_page(editor_page_node)
	current_page_node = editor_page_node
	
func show_credits_page():
	# Replace the current page with the credits page
	if current_page_node:
		hide_page(current_page_node)
	show_page(credits_page_node)
	current_page_node = credits_page_node
	
func _on_menu_page_editor_clicked() -> void:
	show_editor_page()

func _on_menu_page_credits_clicked() -> void:
	show_credits_page()

func _on_credits_page_close_clicked() -> void:
	show_menu_page()

func _on_editor_page_close_clicked() -> void:
	show_menu_page()
