extends Node

func attack_calc(defender: Node2D):
	printt("attack_calc: ", defender) 
	defender.die()
	#defender.hp -= 10

var save_path := "user://debug_variables.tres" # <- tres is Text RESource

@export var debug_data: DebugVariables

func _ready():
# func load_debug() -> void:
	debug_data = load(save_path)

	if not debug_data:
		debug_data = DebugVariables.new()
	printt(debug_data, debug_data.isKingRunning)

func save_debug(key, value) -> void:
	var data := DebugVariables.new()
	data[key] = value

	var error := ResourceSaver.save(data, save_path)
	if error:
		printt("An error happened while saving data: ", error)

var dead = false