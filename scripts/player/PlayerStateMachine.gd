extends Node

class_name PlayerStateMachine

var current_state = null
var previous_state = null
var states = {}
var player = null

func _ready():
	for child in get_children():
		if child is PlayerState:
			states[child.state_name] = child
			child.state_machine = self
			child.player = player

	if "IDLE" in states:
		change_state("IDLE")

func change_state(state_name: String):
	if state_name not in states:
		push_error("State not found: " + state_name)
		return

	if current_state:
		previous_state = current_state
		current_state.exit()

	current_state = states[state_name]
	current_state.enter()

func get_current_state() -> String:
	if current_state:
		return current_state.state_name
	return "UNKNOWN"

func _physics_process(delta):
	if current_state:
		current_state._physics_process(delta)

func _process(delta):
	if current_state:
		current_state._process(delta)
