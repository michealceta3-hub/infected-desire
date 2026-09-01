extends PlayerState

func _ready():
	state_name = "IDLE"

func enter():
	if player.animated_sprite:
		player.animated_sprite.animation = "idle"

func _physics_process(delta):
	if not player:
		return

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if input_vector.x != 0:
		state_machine.change_state("RUN")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("JUMP")
		return

	if Input.is_action_just_pressed("attack"):
		state_machine.change_state("ATTACK")
		return

	if Input.is_action_just_pressed("magic"):
		state_machine.change_state("MAGIC")
		return

	if Input.is_action_just_pressed("dash"):
		state_machine.change_state("DASH")
		return

	apply_gravity(delta)
	if player.velocity.y > 0:
		state_machine.change_state("FALL")

func apply_gravity(delta):
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
