extends PlayerState

var magic_duration = 0.6
var elapsed_time = 0.0

func _ready():
	state_name = "MAGIC"

func enter():
	if player.animated_sprite:
		player.animated_sprite.animation = "fire_cast"
	elapsed_time = 0.0
	if player.player_stats:
		if player.player_stats.use_stamina(20.0):
			cast_fire_shot()

func _physics_process(delta):
	if not player:
		return

	elapsed_time += delta

	if elapsed_time >= magic_duration:
		state_machine.change_state("IDLE")
		return

	apply_gravity(delta)

func cast_fire_shot():
	if player.fire_magic:
		var direction = 1 if player.sprite_scale > 0 else -1
		player.fire_magic.cast_fire_shot(player.global_position, direction)

func apply_gravity(delta):
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
