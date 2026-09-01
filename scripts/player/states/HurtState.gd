extends PlayerState

var hurt_duration = 0.3
var elapsed_time = 0.0
var knockback_force = 200.0
var knockback_direction = -1.0

func _ready():
	state_name = "HURT"

func enter():
	if player.animated_sprite:
		player.animated_sprite.animation = "hurt"
	elapsed_time = 0.0
	knockback_direction = -1 if player.sprite_scale > 0 else 1
	player.velocity.x = knockback_direction * knockback_force

func _physics_process(delta):
	if not player:
		return

	elapsed_time += delta

	if elapsed_time >= hurt_duration:
		state_machine.change_state("IDLE")
		return

	apply_gravity(delta)

func apply_gravity(delta):
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
