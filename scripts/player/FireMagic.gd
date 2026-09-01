extends Node2D

class_name FireMagic

var fire_shot_scene = preload("res://scenes/effects/FireShot.tscn")
var player_position = Vector2.ZERO

func cast_fire_shot(position: Vector2, direction: float = 1.0):
	if fire_shot_scene:
		var projectile = fire_shot_scene.instance()
		add_child(projectile)
		projectile.global_position = position
		projectile.direction = direction
		projectile.damage = 15.0
