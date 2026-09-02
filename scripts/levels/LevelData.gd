# Level data structure for map design and enemy placement

extends Node

class_name LevelData

var level_name = ""
var level_id = 0
var background_path = ""
var tileMap = null
var spawn_points = []
var checkpoints = []
var enemies = []
var boss = null
var dialogue_sequence = []

func _init(name: String, id: int):
	level_name = name
	level_id = id

func add_spawn_point(position: Vector2, enemy_type: String):
	spawn_points.append({
		"position": position,
		"type": enemy_type
	})

func add_checkpoint(id: String, position: Vector2):
	checkpoints.append({
		"id": id,
		"position": position
	})

func add_dialogue(id: String, speaker: String, text: String):
	dialogue_sequence.append({
		"id": id,
		"speaker": speaker,
		"text": text
	})
