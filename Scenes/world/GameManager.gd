extends Node


var mainScene: Node = null
var player: Node = null

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
	printt(debug_data, debug_data.king_run)

func save_debug_var(key, value) -> void:
	# var data := DebugVariables.new()
	debug_data[key] = value
	var error := ResourceSaver.save(debug_data, save_path)
	printt(debug_data, key, value, error, debug_data)
	if error:
		printt("An error happened while saving data: ", error)

var dead = false

func isNthFrame(anim_player, n):
	printt(anim_player, n, floor(anim_player.get_current_animation_position()*5), floor(anim_player.get_current_animation_length()*5))
	if n < 0:
		return floor(anim_player.get_current_animation_position()*5) == floor(anim_player.get_current_animation_length()*5 + n)
	else:
		return floor(anim_player.get_current_animation_position()*5) == n
