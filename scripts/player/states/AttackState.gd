extends PlayerState

var attack_duration = 0.4
var elapsed_time = 0.0

func _ready():
	state_name = "ATTACK"

func enter():
	if player.animated_sprite:
		player.animated_sprite.animation = "attack"
	elapsed_time = 0.0
	if player.player_stats:
		if player.player_stats.use_stamina(15.0):
			pass

func _physics_process(delta):
	if not player:
		return

	elapsed_time += delta

	if elapsed_time >= attack_duration:
		state_machine.change_state("IDLE")
		return

	apply_gravity(delta)

func apply_gravity(delta):
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
