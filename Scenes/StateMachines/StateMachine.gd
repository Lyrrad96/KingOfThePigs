# StateMachine.gd
extends Node
class_name StateMachine

@export var initial_state: String
@onready var current_state: State = null
@onready var states = {
	"IdleState": IdleState,
	"RunState": RunState
}

func _ready():
	change_state(initial_state)

func change_state(new_state_name: String, data = {}):
	if current_state:
		current_state.exit()

	current_state = states[new_state_name]
	current_state.enter(data)
	current_state.state_machine = self  # Set the state machine reference in the new state

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
