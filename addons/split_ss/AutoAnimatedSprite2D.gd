@tool
extends AnimatedSprite2D

class_name AutoAnimatedSprite2D

## Folder which contains all the character animations as individual spritesheets
@export_dir var sprite_folder: String = "res://Sprites"  # Folder to load sprites from
## The height and width of each frame
@export var frame_size: Vector2 = Vector2(0, 0)  # Size of each frame (in pixels)
## If feet of the character touch the bottom of the frame
# @export var feet_on_ground: bool = true

# checkbox to call the function
@export var generate_animation: bool = false
@export var overwrite: bool = false

# Function to update the SpriteFrames resource
func update_sprite_frames():
	# Add spriteframes to AnimatedSprite2D
	if not sprite_frames:
		sprite_frames = SpriteFrames.new()
	
	# Give path to folder with all sprites
	var dir = DirAccess.open(sprite_folder)
	var files = dir.get_files()
	printt('update_sprite_frames', sprite_frames, dir, files[0].split('(')[1].split(')')[0].split('x'))
	var dims = files[0].split('(')[1].split(')')[0].split('x')
	frame_size = Vector2(float(dims[0]), float(dims[1]))
	if dir:
		dir.list_dir_begin()
		sprite_frames.remove_animation("default")

		# traverse every file in the folder
		for file_name in files:
			if file_name.ends_with(".png"):  # Adjust for other formats if needed

				# load the current file as a texture
				var texture = load(sprite_folder + '/' + file_name)

				# set filter to nearest to remove blur
				texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
				# to move bottom of image to x axis (but legs may not always be on ground)
				# if feet_on_ground:
				global_position.y = -frame_size.y/2
				
				# use name of file as name of animation (remove extension and dimensions in brackets) Attack(38x28).png -> Attack
				var anim_name = file_name.split('.')[0].split(' (')[0]
				if anim_name not in sprite_frames.get_animation_names():
					sprite_frames.add_animation(anim_name)
				
					slice_texture(sprite_frames, anim_name, texture)
			file_name = dir.get_next()
		dir.list_dir_end()
	self.frames = sprite_frames

	add_state_machine()
	add_animation_player()

var fsm
func add_state_machine():
	fsm = create_child(FiniteStateMachine, 'FiniteStateMachine')
	# printt('pp', get_parent().find_children("FSM"), get_parent().get_children())
	# add_state('Jump')
	# add_state('Attack')

func add_animation_player():
	var anim_play = create_child(AnimationPlayer, "AnimationPlayer")
	print(anim_play)
	if anim_play:
		convert_sprites(self, anim_play)

# Function to slice the texture into frames based on frame_size
func slice_texture(sprite_frames: SpriteFrames, file_name: StringName, texture: Texture2D):
	var texture_size = texture.get_size()

	# get number of frames from the frame size and image size
	var rows = int(texture_size.y / frame_size.y)
	var cols = int(texture_size.x / frame_size.x)

	# traverse through each frame
	for row in range(rows):
		for col in range(cols):

			# The region of each frame (startX, startY, width, height)
			var region = Rect2(col * frame_size.x, row * frame_size.y, frame_size.x, frame_size.y)

			# create new atlas texture with the new region
			var frame_texture = AtlasTexture.new()
			frame_texture.atlas = texture
			frame_texture.region = region
			# printt(startx, starty, width, height, region, texture.get_size(), frame_texture.region, frame_texture.get_size())

			sprite_frames.add_frame(file_name, frame_texture)

func convert_sprites(animated_sprite, anim_player: AnimationPlayer):
	# var animated_sprite = get_node(get_animatedsprite().get_path())

	var count := 0
	var updated_count := 0

	var sprite_frames = animated_sprite.sprite_frames
	# printt('convert_sprites', animated_sprite)
	if not sprite_frames:
		print("[AS2P]k Selected AnimatedSprite2D has no frames!")

	for anim in sprite_frames.get_animation_names():
		# print(anim, anim_player.root_node)
		if anim.is_empty():
			printerr("[AS2P]k SpriteFrames on AnimatedSprite2D '%s' has an \
			animation named empty string '', it will be ignored" % animated_sprite.name)
			continue
		# printt('asd', anim_player.root_node, anim_player.get_node(anim_player.root_node), anim_player.get_node(anim_player.root_node).get_path_to(animated_sprite))
		var updated = add_animation(
				anim_player.get_node(anim_player.root_node).get_path_to(animated_sprite),
				anim,
				sprite_frames,
				anim_player
			)

		count += 1

		if updated:
			updated_count += 1

	if count - updated_count > 0:
		print("[AS2P] Added %d animations!" % [count - updated_count])
	if updated_count > 0:
		print("[AS2P] Updated %d animations!" % updated_count)

func add_animation(anim_sprite: NodePath, anim: String, sprite_frames: SpriteFrames, anim_player: AnimationPlayer):
	var frame_count = sprite_frames.get_frame_count(anim)
	var fps = sprite_frames.get_animation_speed(anim)
	var looping = sprite_frames.get_animation_loop(anim)
	# Determine the total animation duration in seconds. First sum the duration
	# of each frame, then divide duration by FPS to get the length in seconds.
	var duration: float = 0
	for i in range(frame_count):
		duration += sprite_frames.get_frame_duration(anim, i)
	duration = duration / fps

	# We add the converted animation to the [Global] animation library,
	# which corresponding to the empty string "" key
	var global_animation_library: AnimationLibrary
	if anim_player.has_animation_library(&""):
		# The [Global] animation library already exists, so get it
		# The only reason we check has_animation_library then call
		# get_animation_library instead of just checking if get_animation_library
		# returns null, is that get_animation_library causes an error when no
		# library is found.
		global_animation_library = anim_player.get_animation_library(&"")
	else:
		# The [Global] animation library does not exist yet, so create it
		global_animation_library = AnimationLibrary.new()
		anim_player.add_animation_library(&"", global_animation_library)

	# SpriteFrames allow characters ":" and "[" in animation names, but not
	# Animation Player library, so sanitize the name
	var sanitized_anim_name = anim.replace(":", "_")
	sanitized_anim_name = sanitized_anim_name.replace("[", "_")

	var updated := false
	var animation: Animation = null

	if global_animation_library.has_animation(sanitized_anim_name):
		animation = global_animation_library.get_animation(sanitized_anim_name)

		updated = true
	else:
		animation = Animation.new()
		global_animation_library.add_animation(sanitized_anim_name, animation)

	# printt('sanitized_anim_name', sanitized_anim_name)
	add_state(sanitized_anim_name)

	var spf = 1/fps
	animation.length = duration

	# SpriteFrames only supports linear looping (not ping-pong),
	# so set loop mode to either None or Linear
	animation.loop_mode = Animation.LOOP_LINEAR if looping else Animation.LOOP_NONE

	# Remove existing tracks
	var animation_name_path := "%s:animation" % anim_sprite
	var frame_path := "%s:frame" % anim_sprite

	var anim_track: int = animation.find_track(animation_name_path, Animation.TYPE_VALUE)
	var frame_track: int = animation.find_track(frame_path, Animation.TYPE_VALUE)

	if frame_track >= 0:
		animation.remove_track(anim_track)
	if anim_track >= 0:
		animation.remove_track(frame_track)

	# Add and create tracks

	frame_track = animation.add_track(Animation.TYPE_VALUE, 0)
	anim_track = animation.add_track(Animation.TYPE_VALUE, 1)

	animation.track_set_path(anim_track, animation_name_path)

	# Use the original animation name from SpriteFrames here,
	# since the track expects a SpriteFrames animation key for the AnimatedSprite2D
	animation.track_insert_key(anim_track, 0, anim)

	animation.track_set_path(frame_track, frame_path)

	animation.value_track_set_update_mode(frame_track, Animation.UPDATE_DISCRETE)
	animation.value_track_set_update_mode(anim_track, Animation.UPDATE_DISCRETE)

	# Initialize first sprite key time
	var next_key_time := 0.0

	for i in range(frame_count):
		# Insert key at next key time
		animation.track_insert_key(frame_track, next_key_time, i)

		# Prepare key time for next sprite by adding duration of current sprite
		# including Frame Duration multiplier
		var frame_duration_multiplier = sprite_frames.get_frame_duration(anim, i)
		next_key_time += frame_duration_multiplier * spf

	global_animation_library.add_animation(sanitized_anim_name, animation)

	return updated

func add_state(state):
	print('add state')
	var state_name = state + 'State'
	
	# Optionally save the script to a file (uncomment the next lines if needed)
	var script_path = "res://addons/split_ss/States/"+state_name+".gd"
	# printt(script_path, FileAccess.file_exists(script_path))
	if not FileAccess.file_exists(script_path) or overwrite:
		var script := GDScript.new()
		var file = FileAccess.open('res://addons/split_ss/stateTemplate.txt', FileAccess.READ)
		script.source_code = file.get_as_text().replace('%s', state)
		# printt('script.source_code', script.source_code)
		var error = ResourceSaver.save(script, script_path, not FileAccess.file_exists(script_path))
	var lscript = load(script_path)
	# var cl = ClassDB.instantiate('AnimationPlayer')
	printt('state_node', state_name, AttackState, fsm, '|', script_path, lscript)
	var state_node = create_child(lscript, state_name, fsm)

func create_child(type, name, parent = get_parent()):
	var child = parent.find_children("*", name)
	printt("parent", child, len(child), not child, type, name, parent)
	if not len(child):
		var a = AddChildNode.new()
		child = a.add_child_node(type, parent, name)
		# parent.find_children("*", name)
		# printt('AddChildNode', a, child)
	else:
		child = child[0]
	# printt("Created child", child)
	return child
