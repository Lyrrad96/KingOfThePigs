@icon("res://addons/fsm-godot/icons/state.png")
extends Node
class_name State

# PRIVATE VARIABLES

# The Finite State Machine that this State is a part of. The FSM is always a parent of the State
@onready var _fsm : FiniteStateMachine = get_parent() as FiniteStateMachine
@onready var _par : = get_parent().get_parent()

## The interval at which the transitions are checked
@export var _check_transition_interval : float = 1
# State VARIABLES
@export_category("Add States...")
# enum Char {WARRIOR, MAGE, THIEF}
# @export_enum  (Char) var new_child = Char.WARRIOR
# @export_enum("Warrior", "Magician", "Thief") var new_child : String = "Thief"
# @export var new_child : String = ''
@export var new_child : State

# checkbox to call the function
@export var submit: bool = false
## The transitions that are a part of this state
var _transitions : Array[Transition]

## The timer that is used to check the transitions
var _check_transition_timer : float = 0.0

func _ready():
	# anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	print('_ready')
	# # Create a new script resource
	# var script := GDScript.new()
	# # var script := SaveFile.new()
	# script.source_code = """
	# 	extends State

	# 	func enter_state():
	# 		print("Script is running on the sprite!")
	# 	"""
	# print(script.source_code)
	# # # Optionally save the script to a file (uncomment the next lines if needed)
	# # var script_path = "res://Scenes/Player/States/IdleState.gd"
	# # ResourceSaver.save(script, script_path)
	# # script = load(script_path)

	# # Attach the script to the sprite node
	# set_script(script)

	# # Add the sprite node to the current scene
	# add_child(object)

	for child in get_children():
		# All Children of a State should be a Transition
		if child is Transition:
			_transitions.append(child)
		

## Called when the node enters the scene tree for the first time.
func enter_state() -> void:
	# print('enter_state')
	pass


## Called when the node is about to be removed from the scene tree.
func exit_state() -> void:
	pass
	

## Called every frame
func update(_delta : float) -> void:
	# print('update')
	# _check_transition_timer += _delta
	# if _check_transition_timer >= _check_transition_interval:
	# 	_check_transition_timer = 0.0
	_check_transitions()
	

## Called every physics frame
func physics_update(_delta : float) -> void:
	pass


## Checks all the transitions and changes the state if the transition condition is true
func _check_transitions() -> void:
	for transition in _transitions:
		if transition.check_transition():
			# Transition condition is true, Change to Target state
			_fsm.change_state(transition.target_state)

func addchild():
	var a = AddChildNode.new()
	a.add_child_node(Transition, self, 'Transition')
	printt('AddChildNode', a)