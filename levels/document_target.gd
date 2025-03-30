class_name DocumentChecker

extends Control

@onready var zone_container: Control = $Zones

func check_zones(words: Array[SpeechWord]):
	var output: Array[String] = []
	for zone in zone_container.get_children():
		output.append(zone.text)
		var match_overlap = Rect2()
		for word in words:
			var overlap = word.get_global_rect().intersection(zone.get_global_rect())
			if overlap.get_area() > match_overlap.get_area():
				match_overlap = overlap
				output[output.size()-1] = word.text
				
	return output

func initialize_values(initial_values: Array[String]):
	var zone_children = zone_container.get_children()
	if initial_values.size() != zone_children.size():
		print("ERROR: MISSMATCH VALUE COUNT IN INITIAL VALUES" + str(initial_values))
		return
	for index in range(zone_children.size()):
		var zone = zone_children[index]
		zone.text = initial_values[index].capitalize()
