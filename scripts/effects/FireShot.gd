extends Area2D

var direction = 1.0
var damage = 15.0
var speed = 400.0
var lifetime = 3.0

func _ready():
	yield(get_tree(), "idle_frame")
	var timer = 0.0
	while timer < lifetime:
		global_position.x += direction * speed * get_physics_process_delta_time()
		timer += get_physics_process_delta_time()
		yield(get_tree(), "idle_frame")
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy_hurtbox"):
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage)
		queue_free()
