extends Node2D

class_name Projectile

var damage = 15.0
var speed = 400.0
var direction = Vector2.RIGHT
var lifetime = 5.0
var hit_targets = []

func _ready():
	var timer = 0.0
	while timer < lifetime:
		global_position += direction * speed * get_physics_process_delta_time()
		timer += get_physics_process_delta_time()
		yield(get_tree(), "idle_frame")
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		if area not in hit_targets:
			hit_targets.append(area)
			if area.has_method("take_damage"):
				area.take_damage(damage)
