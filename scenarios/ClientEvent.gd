class_name ClientEvent
extends ScenarioEvent

@export var client_name: String = "Unnamed"
@export var client_image: String = "default.png"
@export var client_text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus imperdiet."
@export var document_inital_values: Dictionary[String, String] = {}
@export var document_expected_values: Dictionary[String, String] = {}

func _init(
  p_name: String = "Untitled",
  p_client_name: String = "Unnamed",
  p_client_image: String = "default.png",
  p_client_text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus imperdiet.",
  p_document_inital_values: Dictionary[String, String] = {},
  p_document_expected_values: Dictionary[String, String] = {}
):
	super._init(p_name, "client")
	client_name = p_client_name
	client_image = p_client_image
	client_text = p_client_text
	document_inital_values = p_document_inital_values
	document_expected_values = p_document_expected_values
