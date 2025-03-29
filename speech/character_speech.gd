extends VBoxContainer

@onready var speech_container: HFlowContainer = $PanelContainer/MarginContainer/SpeechText
var speech_word_scene: PackedScene = preload("res://speech/speech_word.tscn")
var current_timer: SceneTreeTimer
var is_writing: bool = false

@export_group("Speech Properties")
@export var speech_text: String:
	set(value):
		print("Setting speech_text")
		if is_node_ready():
			create_speech_labels(value)
			
func _ready() -> void:
	create_speech_labels(speech_text)

func create_speech_labels(text: String):
	is_writing = false
	if current_timer and current_timer.time_left > 0:
		await current_timer.timeout
	
	# Remove the existing words
	for node in speech_container.get_children():
		node.queue_free()
	
	# Cleanup the input text from all the carriage return or tabs
	text = text.replace("\n", " ").replace("\t", " ")
	is_writing = true
	for word in text.split(" "):
		if not is_writing:
			break
		# An empty word might happen if the text has double spaces
		if not word:
			continue
			
		# Create and instantiate the label node
		current_timer = get_tree().create_timer(0.1)
		await current_timer.timeout
		var word_node = speech_word_scene.instantiate()
		word_node.text = word
		speech_container.add_child(word_node)
