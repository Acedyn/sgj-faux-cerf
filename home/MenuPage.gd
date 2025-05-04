extends Control

signal play_new_clicked
signal editor_clicked
signal credits_clicked

func _on_play_new_button_clicked() -> void:
	play_new_clicked.emit()

func _on_editor_button_clicked() -> void:
	editor_clicked.emit()

func _on_credits_button_clicked() -> void:
	credits_clicked.emit()
