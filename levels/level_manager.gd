class_name HoveredWord
extends Control

@onready var prospectus_container: ProspectusContainer = $ProspectusContainer
@onready var target_container: Control = $DocumentContainer
@onready var current_target: DocumentChecker = $DocumentContainer/DocumentTarget
@onready var character_speech: VBoxContainer = $CharacterSpeech
@onready var words_container: Control = $WordsContainer
@onready var result_container: ResultContainer = $ResultContainer
@onready var manchette_container: ManchetteContainer = $ManchetteContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_texture: TextureRect = $CharacterContainer/CharacterTexture
@onready var available_documents: Dictionary[String, Resource] = {
	"an": preload("res://levels/target_an.tscn"),
	"cni": preload("res://levels/target_cni.tscn"),
	"ct": preload("res://levels/target_ct.tscn"),
}
var levels: Array[Dictionary]
var current_level: Dictionary
var level_number = 0;
@export var manchette_number = -1;

func _ready() -> void:
	GlobalSignals.word_drag_in.connect(_on_word_drag_in)
	var levels_file = FileAccess.open("res://levels/discours.txt", FileAccess.READ)
	var entries = levels_file.get_csv_line()
	while !levels_file.eof_reached():
		var level = {}
		var level_data = levels_file.get_csv_line()
		if level_data.size() != entries.size():
			continue
		for i in range(entries.size()):
			var entry = entries[i]
			level[entry] = level_data[i]
			
		levels.append(level)
	
func _on_word_drag_in(node: SpeechWord):
	var duplicated_word = node.duplicate()
	duplicated_word.text = node.text.lstrip(",.!:?\n").rstrip(",.!:?\n")
	duplicated_word.state = SpeechWord.WordState.SELECTED
	duplicated_word.source = node
	node.state = SpeechWord.WordState.HIDDEN
	var target_texture = current_target.get_node("Texture")
	duplicated_word.doc_target = target_texture.get_global_rect()
	words_container.add_child(duplicated_word)

func select_level():
	# Clear the writted words
	for child in words_container.get_children():
		child.queue_free()
		
	# If there is a level already loaded, clear it
	if current_level:
		character_speech.speech_text = ""
		animation_player.play("doc_animation_out")
		await animation_player.animation_finished
		animation_player.play("character_animation_out")
		await animation_player.animation_finished
		
	# Filter out the speeches that are not available yet according to the
	# current manchette
	var filtered_level = levels
	var level = filtered_level[level_number]
	current_level = level
	level_number += 1
		
	# Show a manchette is specified in the level
	while int(current_level["Manchette"].split("-")[0]) > manchette_number:
		await manchette_container.show_next_manchette(manchette_number+1)
		manchette_number += 1
		
	# Load the character's texture
	if current_target:
		current_target.queue_free()
	var character_texture_path = "res://characters/" + current_level.get("Sprite", "default").to_lower() + ".png"
	var texture = load(character_texture_path)
	if not texture:
		texture = load("res://characters/default.png")
		print("ERROR: Could not load character sprite: " + current_level.get("Sprite", "default.png"))
	character_texture.texture = texture
	
	# Load the available prospectus
	var prospectus_indexes: Array[int] = []
	prospectus_indexes.assign(Array(current_level["Prospectus dispo"].split(",")).map(func(x): return int(x)))
	await prospectus_container.create_prospectus_buttons(
		prospectus_indexes
	)
		
	# Start the next level
	animation_player.play("character_animation_in")
	await animation_player.animation_finished
	# Show the dialogue
	character_speech.speech_text = level["Dialogue"]
	
	# Load the right document
	current_target = available_documents[current_level["Type document"].to_lower()].instantiate()
	target_container.add_child(current_target)
	current_target.initialize_values(current_level["Mots du document"].split(";"))
	animation_player.play("doc_animation_in")
	await animation_player.animation_finished


func compute_score(result: Array[String]):
	var score = 0
	var answer: Array[String] = []
	answer.assign(current_level["Bons mots"].split(";"))
	if answer.size() != result.size():
		print("ERROR: MISSMATCH VALUE COUNT IN ANSWER: " + str(answer))
		return score
		
	for value_index in result.size():
		print(result[value_index].to_lower() + " - " + str(Array(answer[value_index].split(",")).map(func(x: String): return x.to_lower())))
		if result[value_index].to_lower() in Array(answer[value_index].split(",")).map(func(x: String): return x.to_lower()):
			score += 1
			
	return float(score) / result.size()
	

func _on_validate_button_pressed() -> void:
	var children: Array[SpeechWord] = []
	for child in words_container.get_children():
		children.append(child)
	var score = compute_score(current_target.check_zones(children))
	await result_container.show_score(score)


func _on_continue_button_pressed() -> void:
	await result_container.hide_score()
	await select_level()
