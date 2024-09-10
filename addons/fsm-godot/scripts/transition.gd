@icon("res://addons/fsm-godot/icons/transition.png")
extends Node
class_name Transition

enum OperatorType {LESS_THAN, EQUAL, MORE_THAN, NOT_EQUAL}
enum ValueType {INT, FLOAT, BOOLEAN}

@onready var _parent_state = get_parent()

## Target State to transition in case condition is true
@export var target_state : State
@export_category("Condition")
@export_category("Variable name = EXACT MATCH")
@export var _variable_name : String ## Variable name to check
@export var _operator : OperatorType ## Operator to use for comparison
@export var _value_type : ValueType ## Type of value to compare
@export_category("If type is BOOLEAN, value has to be either 'true' or 'false'")
@export var _value : String ## Value to compare


## Check if condition is true
func check_transition() -> bool:
	# printt('\ncheck_transition', _variable_name)
	if not len(_variable_name):
		return false
	# var parent_value
	# if _variable_name.contains('.'):
	# 	var v_arr = _variable_name.split('.')
	# 	var p = _parent_state._par
	# 	var v
	# 	printt(v_arr, p, v)
	# 	for i in v_arr:
	# 		p = p.get(i)
	# 		printt(i, v)
	# 	parent_value = p
	# else:
	# var parent_value = _parent_state._par.get(_variable_name)
	var parent_value = _parent_state.get(_variable_name)
	# printt('parent_value', _variable_name, parent_value, _parent_state.name, type_string(typeof(parent_value)), _parent_state._par)
	# printt('check_transition', parent_value)
	match _operator:
		OperatorType.LESS_THAN:
			match _value_type:
				ValueType.INT:
					if int(parent_value) < int(_value):
						return true
				ValueType.FLOAT:
					if float(parent_value) < float(_value):
						return true
		OperatorType.MORE_THAN:
			match _value_type:
				ValueType.INT:
					if int(parent_value) > int(_value):
						return true
				ValueType.FLOAT:
					if float(parent_value) > float(_value):
						return true
		OperatorType.EQUAL:
			match _value_type:
				ValueType.INT:
					if int(_value) == int(parent_value):
						return true
				ValueType.FLOAT:
					if float(_value) == float(parent_value):
						return true
				ValueType.BOOLEAN:
					if string_to_bool(_value) == parent_value:
						return true
		OperatorType.NOT_EQUAL:
			# printt(get_parent().get_parent().get_parent(), type_string(typeof(_value)), type_string(typeof(parent_value)))
			match _value_type:
				ValueType.INT:
					if int(_value) != int(parent_value):
						return true
				ValueType.FLOAT:
					if float(_value) != float(parent_value):
						return true
				ValueType.BOOLEAN:
					if string_to_bool(_value) != parent_value:
						return true

	return false

## Convert string to boolean
func string_to_bool(s: String) -> bool:
	return s.to_lower() == "true"


# Function to get the opposite of the given OperatorType
func get_opposite_operator(op: OperatorType) -> OperatorType:
	print(op)
	return (int(op) + 2) % 4
