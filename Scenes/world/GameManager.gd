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

func get_anim_frame(animation_player: AnimationPlayer, current_anim, n: int, delta) -> bool:
	# var animation = animation_player.get_animation(current_anim)
	var animation = animation_player.get_current_animation()
	var anim_length = animation_player.get_current_animation_length()
	var pos = animation_player.get_current_animation_position()
	printt(pos, delta, pos/anim_length, anim_length/.0333)
	# printt(animation, anim_length, pos, delta, pos/delta, animation_player.get_playing_speed())
	# var fps = animation.fps # Retrieve the fps (frames per second) of the animation
	# if fps <= 0:
	# 	return false # Avoid division by zero or invalid fps

	# var num_frames = anim_length * fps
	# var frame_duration = anim_length / num_frames
	# if n < 0:
	# 	n = num_frames - n
	# var target_frame_time = frame_duration * (n - 1) # Time position of the nth frame (0-based index)
	# var current_time = animation_player.position
	# var threshold = 0.02 # Adjust this as needed for precision

	# return abs(current_time - target_frame_time) < threshold
	return false