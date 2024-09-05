extends Node
class_name StateMachine2

var state = null
var previous_state = null

var states: Dictionary = {}

@onready var parent = get_parent()

func _physics_process(delta):
    if state != null:
        _state_logic(delta)
        var transition = _get_transition(delta)
        if transition != null:
            set_state(transition)

func _state_logic(delta):
    pass

func _get_transition(delta):
    return null

func enter(new_state, old_state):
    pass

func exit(old_state, new_state):
    pass

func set_state(new_state):
    previous_state = state
    state = new_state

    if previous_state != null:
        exit(previous_state, new_state)
    if new_state != null:
        enter(new_state, previous_state)

func add_state(state_name):
    states[state_name] = states.size()