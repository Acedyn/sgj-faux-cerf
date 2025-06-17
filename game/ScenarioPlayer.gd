class_name ScenarioPlayer
extends Control

@onready var news_container: Control = $NewsContainer
@onready var news_texture: NewsTexture = $NewsContainer/NewsTexture
@onready var news_continue_button: Control = $NewsContainer/ContinueNewsButton
@onready var client_container: Control = $ClientContainer
@onready var client_texture: TextureRect = $ClientContainer/ClientTexture
@onready var client_continue_button: Control = $ClientContainer/ContinueClientButton
@export var scenario: Scenario:
	set(value):
		scenario = value
		current_event_index = 0
var current_event_index: int = 0
	
func play_next_event():
	var current_event = scenario.events[current_event_index]
	if current_event is NewsEvent:
		await play_news_event(current_event)
	if current_event is ClientEvent:
		await play_client_event(current_event)
		
	current_event_index = current_event_index + 1
	if current_event_index < scenario.events.size():
		play_next_event()
		
func play_news_event(event: NewsEvent):
	news_container.visible = true
	client_container.visible = false
	news_texture.news_event = event
	news_texture.show_news()
	await news_continue_button.clicked
	await news_texture.hide_news()
	
func play_client_event(event: ClientEvent):
	news_container.visible = false
	client_container.visible = true
	# Load the character's texture
	var character_texture_path = "res://assets/characters/" + event.client_image
	var texture = load(character_texture_path)
	if not texture:
		texture = load("res://assets/characters/default.png")
		print("ERROR: Could not load character sprite: " + event.client_image)
	client_texture.texture = texture
	await news_continue_button.clicked
