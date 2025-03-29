class_name DocumentChecker

extends Control

@onready var zone_container: Control = $Zones

func check_zones(words: Array[SpeechWord]):
	var output = {}
	for zone in zone_container.get_children():
		output[str(zone.name)] = ""
		var match_overlap = Rect2()
		for word in words:
			var overlap = word.get_global_rect().intersection(zone.get_global_rect())
			if overlap.get_area() > match_overlap.get_area():
				match_overlap = overlap
				output[zone.name] = word.text
				
	return output
