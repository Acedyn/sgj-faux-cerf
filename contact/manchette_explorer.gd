class_name ManchetteExplorer

extends ColorRect

@onready var animation_player: AnimationPlayer = $ManchetteExplorerPlayer
@onready var continue_button: TextureButton = $ContinueButton
@onready var manchette_container: HBoxContainer = $MarginContainer/ScrollContainer/VBoxContainer

func _ready() -> void:
	visible = false
	
func show_manchettes(manchette_level: int):
	# Clear the existing manchette
	for child in manchette_container.get_children():
		child.queue_free()
		
	for index in range(manchette_level):
		var manchette_path = "res://contact/manchettes/manchette_" + str(index) + ".png"
		var manchette_texture = TextureRect.new()
		manchette_texture.texture = load(manchette_path)
		manchette_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		manchette_container.add_child(manchette_texture)
		
	visible = true
	animation_player.play("manchette_explorer_in")
	await animation_player.animation_finished
	await continue_button.pressed
	await hide_manchettes()

func hide_manchettes():
	animation_player.play("manchette_explorer_out")
	await animation_player.animation_finished
	visible = false


func _on_manchette_menu_pressed() -> void:
	show_manchettes(get_parent().manchette_number+1)


func _on_continue_button_pressed() -> void:
	hide_manchettes()
