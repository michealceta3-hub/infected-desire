extends Node

var save_path = "user://infected_desire/"
var current_save = "save_slot_1.json"

func _ready():
	if not Directory.new().dir_exists(save_path):
		Directory.new().make_absolute(save_path)

func save_game(data: Dictionary) -> bool:
	var full_path = save_path + current_save
	var file = File.new()
	if file.open(full_path, File.WRITE) != OK:
		push_error("Failed to save game")
		return false
	file.store_var(data)
	return true

func load_game() -> Dictionary:
	var full_path = save_path + current_save
	var file = File.new()
	if file.open(full_path, File.READ) != OK:
		push_warning("No save file found")
		return {}
	var data = file.get_var()
	return data if data else {}

func delete_save() -> bool:
	var full_path = save_path + current_save
	return Directory.new().remove(full_path) == OK
