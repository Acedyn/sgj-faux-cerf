class_name ResultContainer

extends ColorRect

@onready var animation_player: AnimationPlayer = $ResultPlayer
@onready var score_label: Label = $ScoreContainer/Label

func _ready() -> void:
	visible = false
	
func show_score(score: float):
	score_label.text = str(int(score*100)) + "%"
	visible = true
	if score > 0.5:
		animation_player.play("result_in_passed")
	else:
		animation_player.play("result_in_refused")
	await animation_player.animation_finished

func hide_score():
	animation_player.play("result_out")
	await animation_player.animation_finished
	visible = false
