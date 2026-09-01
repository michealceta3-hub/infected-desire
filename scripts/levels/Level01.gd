extends Node2D

func _ready():
	GlobalSignals.emit_signal("level_loaded", "Level 01")
