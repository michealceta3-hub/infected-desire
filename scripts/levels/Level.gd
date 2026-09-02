extends Node2D

class_name Level

var level_data: LevelData
var player: Player
var enemies = []
var checkpoints = {}
var tilemap: TileMap

func _ready():
	player = get_tree().get_first_node_in_group("player")
	tilemap = $TileMap if has_node("TileMap") else null
	
	for child in get_children():
		if child is Enemy:
			enemies.append(child)
			GlobalSignals.connect("enemy_died", self, "_on_enemy_died")

func _on_enemy_died(enemy: Enemy):
	if enemy in enemies:
		enemies.erase(enemy)
		if enemies.size() == 0:
			on_all_enemies_defeated()

func on_all_enemies_defeated():
	GlobalSignals.emit_signal("level_complete")

func get_tilemap() -> TileMap:
	return tilemap
