extends Node2D

@onready var level_manager: HoveredWord = $Control/LevelManager

func start_game():
	level_manager.select_level()
