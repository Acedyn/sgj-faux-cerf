class_name NewsTexture
extends TextureRect

@onready var title_node: Label = $Title
@onready var paragraph_node: RichTextLabel = $Parahraph
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var news_event: NewsEvent:
	set(value):
		news_event = value
		title_node.text = value.title
		paragraph_node.text = value.paragraphs[0]

func show_news():
	animation_player.play("show")
	await animation_player.animation_finished
	
func hide_news():
	animation_player.play("hide")
	await animation_player.animation_finished
