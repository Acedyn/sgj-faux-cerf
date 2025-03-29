extends VBoxContainer

@onready var speech_container: HFlowContainer = $PanelContainer/MarginContainer/SpeechText

@export_group("Speech Properties")
@export var speech_text: String:
	set(value):
		print("Setting speech_text")
		if is_node_ready():
			create_speech_labels(value)
			
func _ready() -> void:
	create_speech_labels(speech_text)

func create_speech_labels(text: String):
	# Remove the existing words
	for node in speech_container.get_children():
		node.queue_free()
	
	# Cleanup the input text from all the carriage return or tabs
	text = text.replace("\n", " ").replace("\t", " ")
	for word in text.split(" "):
		# An empty word might happen if the text has double spaces
		if not word:
			continue
			
		# Create and instantiate the label node
		var word_node = Label.new()
		word_node.text = word
		speech_container.add_child(word_node)
