extends PlayerState

var dash_duration = 0.3
var dash_speed = 400.0
var elapsed_time = 0.0
var direction = 1.0

func _ready():
	state_name = "DASH"

func enter():
	if player.animated_sprite:
		player.animated_sprite.animation = "dash"
	elapsed_time = 0.0
	direction = 1 if player.sprite_scale > 0 else -1
	if player.player_stats:
		if not player.player_stats.use_stamina(25.0):
			state_machine.change_state("IDLE")

func _physics_process(delta):
	if not player:
		return

	elapsed_time += delta

	player.velocity.x = direction * dash_speed
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if elapsed_time >= dash_duration:
		state_machine.change_state("IDLE")
