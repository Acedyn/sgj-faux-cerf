extends Node

signal scenarios_updated
var scenario_script: Script = preload("res://scenarios/Scenario.gd")
@export var scenarios_search_paths: Array[String] = []
@export var scenarios: Dictionary[String, Scenario] = {}:
	set(value):
		scenarios = value
		scenarios_updated.emit()

func _init(p_scenarios: Dictionary[String, Scenario] = {}):
	scenarios = p_scenarios.merged(find_scenarios([
		"res://scenarios/examples/"
	]))

func find_scenarios(scenarios_search_paths: Array[String] = []) -> Dictionary[String, Scenario]:
	var found_scenarios: Dictionary[String, Scenario] = {}
	for path in scenarios_search_paths:
		var dir = DirAccess.open(path)
		dir.list_dir_begin()
		var file_name = dir.get_next()  

		while file_name != "":  
			var file_path = path + "/" + file_name
			var ressource = load(file_path)
			var ressource_script = ressource.get_script()
			while ressource_script != null:
				if ressource_script == scenario_script:
					found_scenarios[file_name] = ressource
					break
				ressource_script = ressource_script.get_base_script()
			file_name = dir.get_next()  
			
	return found_scenarios
