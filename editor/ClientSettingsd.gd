extends EventSettings

@onready var client_name_node = $ClientSettingsContainer/ClientTitleContainer/ClientTitleInput/LineEdit
@onready var client_image_node = $ClientSettingsContainer/ClientImageInput/Option
@onready var client_paragraphs_node = $ClientSettingsContainer/ClientParagraphsContainer/ClientParagraphsInput/TextEdit

func get_event_type() -> String:
	return "client"
	
func build_event(event_name: String) -> ClientEvent:
	var client_name = client_name_node.text
	if client_name == "":
		client_name = client_name_node.placeholder_text
	
	var client_image = client_image_node.text
	if client_image == "":
		client_image = "default.png"
		
	var client_paragraphs = client_paragraphs_node.text
	if client_paragraphs == "":
		client_paragraphs = client_paragraphs_node.placeholder_text
		
	return ClientEvent.new(
		event_name,
		client_image,
		client_paragraphs,
	)

func reset() -> void:
	client_name_node.clear()
	client_image_node.clear()
	client_paragraphs_node.clear()
