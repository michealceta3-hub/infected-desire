extends Node

var current_language = "ru"
var available_languages = ["ru", "en", "ro"]
var translations = {}

func _ready():
	load_translations()

func load_translations():
	translations = {
		"ru": load_russian_texts(),
		"en": load_english_texts(),
		"ro": load_romanian_texts()
	}

func set_language(lang: String):
	if lang in available_languages:
		current_language = lang

func get_text(key: String) -> String:
	if current_language in translations:
		if key in translations[current_language]:
			return translations[current_language][key]
	return key

func load_russian_texts() -> Dictionary:
	return {
		"menu_start": "Начать",
		"menu_settings": "Настройки",
		"menu_quit": "Выход",
		"language": "Язык",
		"volume": "Громкость",
		"censorship": "Цензура (18+)",
		"game_over_title": "КОНЕЦ ИГРЫ",
		"game_over_text": "Заражение поглотило тебя.",
		"retry": "Повторить",
		"load_game": "Загрузить",
		"main_menu": "Главное меню"
	}

func load_english_texts() -> Dictionary:
	return {
		"menu_start": "Start",
		"menu_settings": "Settings",
		"menu_quit": "Quit",
		"language": "Language",
		"volume": "Volume",
		"censorship": "Censorship (18+)",
		"game_over_title": "GAME OVER",
		"game_over_text": "The infection has consumed you.",
		"retry": "Retry",
		"load_game": "Load",
		"main_menu": "Main Menu"
	}

func load_romanian_texts() -> Dictionary:
	return {
		"menu_start": "Start",
		"menu_settings": "Setări",
		"menu_quit": "Ieșire",
		"language": "Limba",
		"volume": "Volum",
		"censorship": "Censură (18+)",
		"game_over_title": "GAME OVER",
		"game_over_text": "Infecția te-a cuprins.",
		"retry": "Reîncercă",
		"load_game": "Încarcă",
		"main_menu": "Meniu Principal"
	}
