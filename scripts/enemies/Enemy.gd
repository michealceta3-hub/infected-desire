extends KinematicBody2D

class_name Enemy

var enemy_type = "goblin"
var max_hp = 30.0
var hp = 30.0
var damage = 10.0
var move_speed = 100.0
var gravity = 1000.0
var velocity = Vector2.ZERO
var facing_right = true

var player: Player
var animated_sprite: AnimatedSprite
var collision_shape: CollisionShape2D

var ai_state = "PATROL"
var patrol_distance = 200.0
var detection_range = 300.0
var attack_range = 50.0
var patrol_timer = 0.0
var patrol_direction = 1.0
var start_position = Vector2.ZERO

func _ready():
	animated_sprite = $AnimatedSprite
	collision_shape = $CollisionShape2D
	start_position = global_position
	hp = max_hp
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if ai_state == "PATROL":
		patrol(delta)
	elif ai_state == "CHASE":
		chase(delta)
	elif ai_state == "ATTACK":
		attack(delta)

	apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)

func patrol(delta):
	if player and global_position.distance_to(player.global_position) < detection_range:
		ai_state = "CHASE"
		return

	patrol_timer += delta
	if patrol_timer > 2.0:
		patrol_direction *= -1
		patrol_timer = 0.0

	velocity.x = patrol_direction * move_speed
	update_facing()

	if abs(global_position.x - start_position.x) > patrol_distance:
		patrol_direction *= -1

func chase(delta):
	if not player:
		ai_state = "PATROL"
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player > detection_range + 100:
		ai_state = "PATROL"
		return

	if distance_to_player < attack_range:
		ai_state = "ATTACK"
		return

	var direction = sign(player.global_position.x - global_position.x)
	velocity.x = direction * move_speed * 1.5
	update_facing()

func attack(delta):
	if not player:
		ai_state = "PATROL"
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player > attack_range + 50:
		ai_state = "CHASE"
		return

	velocity.x = 0
	if player.player_stats:
		player.player_stats.take_damage(damage, enemy_type)

	yield(get_tree(), "idle_frame")
	for i in range(30):
		yield(get_tree(), "idle_frame")

func take_damage(damage: float):
	hp -= damage
	if hp <= 0:
		die()

func die():
	GlobalSignals.emit_signal("enemy_died", self)
	queue_free()

func apply_gravity(delta):
	velocity.y += gravity * delta

func update_facing():
	if velocity.x > 0:
		facing_right = true
	elif velocity.x < 0:
		facing_right = false

	if animated_sprite:
		animated_sprite.flip_h = not facing_right

func move_and_slide(velocity: Vector2, floor_normal: Vector2 = Vector2.UP) -> Vector2:
	return .move_and_slide(velocity, floor_normal)
