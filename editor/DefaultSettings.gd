extends EventSettings

func get_event_type() -> String:
	return "default"
	
func build_event(event_name: String) -> NewsEvent:
	return ScenarioEvent.new(
		event_name,
	)
