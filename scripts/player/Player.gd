extends KinematicBody2D

class_name Player

# Movement
var move_speed = 250.0
var jump_force = 400.0
var gravity = 1000.0
var velocity = Vector2.ZERO
var sprite_scale = 1.0

# Components
var player_stats: PlayerStats
var state_machine: PlayerStateMachine
var animated_sprite: AnimatedSprite
var animation_player: AnimationPlayer
var collision_shape: CollisionShape2D
var fire_magic: FireMagic
var camera: Camera2D

# Defeat system
var censorship_enabled = true
var last_attacker_type = ""

func _ready():
	# Get components
	player_stats = $PlayerStats
	state_machine = $StateMachine
	animated_sprite = $AnimatedSprite
	animation_player = $AnimationPlayer
	collision_shape = $CollisionShape2D
	fire_magic = $FireMagic
	camera = $Camera2D

	# Setup state machine
	state_machine.player = self

	# Connect signals
	GlobalSignals.connect("player_defeated", self, "_on_player_defeated")
	
	# Initialize position
	global_position = Vector2(960, 500)

func _physics_process(delta):
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		GlobalSignals.emit_signal("game_paused" if get_tree().paused else "game_resumed")

func is_on_floor() -> bool:
	return is_on_floor()

func move_and_slide(velocity: Vector2, floor_normal: Vector2 = Vector2.UP) -> Vector2:
	return .move_and_slide(velocity, floor_normal)

func _on_player_defeated(attacker_type: String):
	last_attacker_type = attacker_type
	state_machine.change_state("HURT")
	yield(get_tree(), "idle_frame")
	if censorship_enabled:
		show_censored_defeat_scene()
	else:
		show_defeat_scene(attacker_type)

func show_censored_defeat_scene():
	var defeat_scene = get_tree().get_root().add_child(preload("res://scenes/ui/DefeatCensored.tscn"))
	yield(defeat_scene, "tree_exited")
	recover_from_defeat()

func show_defeat_scene(attacker_type: String):
	var defeat_scenes = {
		"goblin": preload("res://scenes/defeat/DefeatGoblin.tscn"),
		"orc": preload("res://scenes/defeat/DefeatOrc.tscn")
	}
	
	if attacker_type in defeat_scenes:
		var defeat_scene = get_tree().get_root().add_child(defeat_scenes[attacker_type].instance())
		yield(defeat_scene, "tree_exited")

func recover_from_defeat():
	if player_stats:
		player_stats.restore_health()
		player_stats.increase_pregnancy(10.0)
		GlobalSignals.emit_signal("player_recovered")
		
		if player_stats.pregnancy >= 100.0:
			trigger_game_over()
		else:
			state_machine.change_state("IDLE")

func trigger_game_over():
	GlobalSignals.emit_signal("game_over", player_stats.pregnancy)
	var game_over_scene = load("res://scenes/ui/GameOver.tscn").instance()
	get_tree().get_root().add_child(game_over_scene)
