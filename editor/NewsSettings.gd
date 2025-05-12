extends EventSettings

@onready var news_title_node = $NewsSettingsContainer/NewsTitleContainer/NewsTitleInput/LineEdit
@onready var news_paragraphs_node = $NewsSettingsContainer/NewsParagraphsContainer/NewsParagraphsInput/TextEdit

func get_event_type() -> String:
	return "news"
	
func build_event(event_name: String) -> NewsEvent:
	var news_title = news_title_node.text
	if news_title == "":
		news_title = news_paragraphs_node.placeholder_text
	
	var news_paragraphs = news_paragraphs_node.text
	if news_paragraphs == "":
		news_paragraphs = news_paragraphs_node.placeholder_text
		
	return NewsEvent.new(
		event_name,
		news_title,
		[news_paragraphs]
	)

func reset() -> void:
	news_title_node.clear()
	news_paragraphs_node.clear()
