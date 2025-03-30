class_name ManchetteContainer

extends ColorRect

@onready var animation_player: AnimationPlayer = $ManchettePlayer
@onready var manchette_texture: TextureRect = $MarginContainer/TextureRect
@onready var continue_button: TextureButton = $ContinueButton
var manchettes: Array[Dictionary] = []

func _ready() -> void:
	visible = false
	
	var manchettes_file = FileAccess.open("res://contact/manchette.txt", FileAccess.READ)
	var entries = manchettes_file.get_csv_line()
	while !manchettes_file.eof_reached():
		var manchette = {}
		var manchette_data = manchettes_file.get_csv_line()
		if manchette_data.size() != entries.size():
			continue
		for i in range(entries.size()):
			var entry = entries[i]
			manchette[entry] = manchette_data[i]
			
		manchettes.append(manchette)
	
func show_next_manchette():
	manchette_texture.texture = load("res://contact/manchette.png")
	visible = true
	animation_player.play("manchette_in")
	await animation_player.animation_finished
	await continue_button.pressed
	await hide_manchette()

func hide_manchette():
	animation_player.play("manchette_out")
	await animation_player.animation_finished
	visible = false
