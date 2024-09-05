@icon("res://addons/fsm-godot/icons/fsm.png")
extends Node
class_name FiniteStateMachine

## Initial State that the State Machine will start with
@export var _initial_state : State

# PRIVATE VARIABLES
@export_category("Runtime filled...")
@export var _current_state : State

# State VARIABLES
@export_category("Add States...")
# @export var anim_player: AnimationPlayer #= get_parent().find_child('AnimationPlayer')
# @export var animToFsm: bool = false
@export var addTrans: bool = false

# @export var init_state : String = ''
@export var new_child : String = ''
#  :
	# get:
	# 	return new_child
	# set(value):
	# 	print(value)
	# 	var a = AddChildNode.new()
	# 	a.add_child_node(Node, self, 'Node')
	# 	# add_child_node()
	# 	new_child = value
# @export_enum("Warrior", "Magician", "Thief") var character_class

# checkbox to call the function
@export var submit: bool = false
#  :
# 	get:
# 		return submit
# 	set(value):
# 		print(submit, new_child)
# 		submit = value

func _ready():
	if _initial_state:
		change_state(_initial_state)
	# anim_player = get_parent().find_children('*', 'AnimationPlayer')[0]
	# print('fsm', anim_player, get_parent().find_children('*', 'AnimationPlayer'))

func _process(delta):
	if _current_state:
		_current_state.update(delta)


func _physics_process(delta):
	if _current_state:
		_current_state.physics_update(delta)


## Change the current state of the State Machine
func change_state(new_state: State):
	if _current_state is State:
		# Exit the current state and enter the new one
		_current_state.exit_state()
	new_state.enter_state()
	# Set the new state as the current one
	_current_state = new_state

func addchild():
	var a = AddChildNode.new()
	a.add_child_node(State, self, 'State')
	printt('AddChildNode', a)
