# extends StateMachine2

# var state = null
# var previous_state = null

# var states: Dictionary = {}

# @onready var parent = get_parent()

# func _ready():
#     add_state("Idle")
#     add_state("Run")
#     add_state("Jump")
#     call_deferred("set_state", states.idle)

# func _input(event):
#     if Input.is_action_just_pressed("Jump") and is_on_floor():
# 		velocity.y = JUMP_VELOCITY
	
# 	if Input.is_action_just_pressed("Attack"):
# 		attack()
	
# 	direction = Input.get_axis("Run Left", "Run Right")
	
# 	# Get the input direction and handle the movement/deceleration.
# 	# As good practice, you should replace UI actions with custom gameplay actions.
# 	if direction:
# 		velocity.x = direction * SPEED
# 		# printt(direction, scale.x, scale, direction == scale.x)
# 		# attack_hitbox.position.x *= -1
# 		# scale = Vector2(-direction, 1)
# 		# scale.y = abs(scale.y)
# 		# if direction != scale.x:
# 		# 	# flip(direction)
# 		# 	# scale.x = direction
# 		# 	scale.x = scale.x * -1
# 		# 	printt(scale)
# 		player_sprite.flip_h = true if direction == 1 else false
# 		# if player_sprite.flip_h and attack_hitbox.get_child(0).scale.x == 1:
# 		attack_hitbox.position.x = 8 if direction == 1 else -8
# 		# elif direction<0 and scale.x == -1:
# 		# 	scale.x = 1#abs(scale.x)
# 		# 	player_sprite.flip_h = false
# 		# 	attack_hitbox.get_child(0).scale.x = 1
			
# 	else:
# 		velocity.x = move_toward(velocity.x, 0, SPEED)



# func _physics_process(delta):

# func _state_logic(delta):
#     pass

# func _get_transition(delta):
#     return null

# func enter(new_state, old_state):
#     pass

# func exit(old_state, new_state):
#     pass

# func set_state(new_state):

# func add_state(state_name):
#     states[state_name] = states.size()