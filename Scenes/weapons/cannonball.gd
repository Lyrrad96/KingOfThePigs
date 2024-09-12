extends RigidBody2D

var speed = -100
var acc = -100
var throw_distance = -329 + 211
var max_height = -40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# velocity.x = speed
	# velocity.y = acc
	
	# velocity = Vector2.ONE * get_parent().JUMP_VELOCITY

	# Calculate initial velocity based on parabolic motion
	initial_velocity = calculate_initial_velocity(initial_position, final_position, flight_time)
	
	# Set initial velocity
	linear_velocity = initial_velocity

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _physics_process(delta: float) -> void:
# 	# velocity.x = speed
# 	# velocity.y += gravity/4 * delta

# 	velocity.y += gravity * delta
# 	# velocity += Vector2.DOWN * gravity * delta
# 	rotation = velocity.angle()

# 	# move_and_collide(velocity)
# 	move_and_slide()

var flight_time = 2.0 # The time for the projectile to reach the final position

# Variables
var initial_position = Vector2(-200, 0)
var final_position = Vector2(-320, -20)
var initial_velocity = Vector2.ZERO

	

# Function to calculate the initial velocity needed to reach the final point
func calculate_initial_velocity(p0: Vector2, pf: Vector2, t: float) -> Vector2:
	var v0x = (pf.x - p0.x) / t
	var v0y = (pf.y - p0.y + 0.5 * gravity * t * t) / t
	return Vector2(-v0x, -v0y)