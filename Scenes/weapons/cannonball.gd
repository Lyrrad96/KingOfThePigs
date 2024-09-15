extends RigidBody2D

var speed = -100
var acc = -100
var throw_distance = -329 + 211
var max_height = -40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# velocity.x = speed
	# velocity.y = acc

	# velocity = Vector2.ONE * get_parent().JUMP_VELOCITY

	# Calculate initial velocity based on parabolic motion
	# initial_velocity = calculate_initial_velocity(initial_position, final_position, flight_time)

	# Set initial velocity
	# linear_velocity = initial_velocity

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var flight_time = 1.0 # The time for the projectile to reach the final position

# Variables
var initial_position = Vector2(200, 0)
var final_position = Vector2(320, -10)
var initial_velocity = Vector2.ZERO

var target_distance = 1000  # Target distance in world units
var launch_angle = 45.0  # Angle in degrees

# Function to calculate the initial velocity needed to reach the final point
func calculate_initial_velocity(p0: Vector2, pf: Vector2, t: float) -> Vector2:
	var v0x = (pf.x - p0.x) / t
	var v0y = (pf.y - p0.y + 0.5 * gravity * t * t) / t
	return Vector2(-v0x, -v0y)

func _on_body_entered(body:Node) -> void:
	# print(body, body.name)
	print('ball out')
	queue_free()


func launch_cannonball():
	# Convert the launch angle to radians
	var theta = deg_to_rad(launch_angle)

	# Calculate the required initial velocity to hit the target
	var initial_velocity = sqrt((target_distance * gravity) / sin(2 * theta))

	# Convert the velocity into a 2D vector (velocity components)
	var velocity_x = initial_velocity * cos(theta)
	var velocity_y = -initial_velocity * sin(theta)  # Negative because up is negative Y

	# Apply the velocity to the RigidBody
	linear_velocity = Vector2(velocity_x, velocity_y)
