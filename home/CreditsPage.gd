extends Control

signal close_clicked

func _on_button_close_clicked() -> void:
	close_clicked.emit()
