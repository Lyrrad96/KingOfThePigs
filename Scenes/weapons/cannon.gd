extends Node2D

var velocity_x = -100
var velocity_y = -200
# @export var velocity_x = -100
# @export var velocity_y = -200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $AnimationPlayer
@onready var game_manager = %GameManager

var min_angle = -60
var max_angle = 90
var angle = 45

var power = 10
# var time = 5

signal shoot(bullet, direction, location)
var ball = preload("res://Scenes/weapons/cannonball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# print(cannon_body)
	# cannon_body.rotation = angle
	# gravity = (2 * power * sin(angle)) / 5
	# print(gravity)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var rot = deg_to_rad(0)
			shoot.emit(ball, rot, position)
			# must_shoot = true
	if event is InputEventKey:
		# print(cannon_body.rotation)
		if event.keycode == KEY_X:
			must_shoot = true
		if event.keycode == KEY_W:
			cannon_body.rotation += deg_to_rad(1)
		if event.keycode == KEY_S:
			cannon_body.rotation -= deg_to_rad(1)

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	look_at(get_global_mouse_position())
# 	# print($Trajectory)
# 	# $Trajectory.update_trajectory(delta)

@onready var cannon_body = $CannonBody
var must_shoot = false
func launch():
	var rot = deg_to_rad(cannon_body.rotation)
	launch_ball(ball, cannon_body.rotation, position)

func launch_ball(bullet:Variant, direction:Variant, location:Variant):
	var spawned_bullet = bullet.instantiate()

	var world = get_tree().root.get_child(0)
	printt(world, world.get_children(), spawned_bullet, game_manager)

	world.add_child(spawned_bullet)
	spawned_bullet.owner = world

	# add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = get_cannonball_position(location, direction)
	# spawned_bullet.position = location - Vector2(10, 10)

	printt('rad_to_deg(direction)', rad_to_deg(direction), position, spawned_bullet.position)

	# spawned_bullet.linear_velocity = spawned_bullet.linear_velocity.rotated(direction)
	print(GameManager.player.global_position, global_position, GameManager.player.global_position - global_position)

	var distance = GameManager.player.global_position - global_position
	spawned_bullet.linear_velocity = compute_initial_speed(distance, 4)

func get_cannonball_position(pivot_position: Vector2, cannon_rotation: float, distance_from_pivot: float = -10) -> Vector2:
	var x = pivot_position.x + distance_from_pivot * cos(cannon_rotation)
	var y = pivot_position.y + (distance_from_pivot * sin(cannon_rotation)-10)

	printt('get_cannonball_position', pivot_position, rad_to_deg(cannon_rotation), distance_from_pivot, x, y)
	return Vector2(x, y)

func _on_shoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	must_shoot = true
	# var rot = deg_to_rad(20)
	# launch_ball(ball, rot, position)


var target_distance = 150  # Target distance in world units
var launch_angle = 0  # Angle in degrees

func get_velocity():
	# Convert the launch angle to radians
	var theta = deg_to_rad(launch_angle)

	# Calculate the required initial velocity to hit the target
	var initial_velocity = sqrt((target_distance * gravity) / sin(2 * theta))

	# Convert the velocity into a 2D vector (velocity components)
	velocity_x = initial_velocity * cos(theta)
	velocity_y = -initial_velocity * sin(theta)  # Negative because up is negative Y

	printt(velocity_x, velocity_y, target_distance)

	# Apply the velocity to the RigidBody
	# ball.linear_velocity = Vector2(velocity_x, velocity_y)
	return Vector2(velocity_x, velocity_y)

func compute_initial_speed(distance: Vector2, time: float) -> Vector2:
	
	var g = 9.8  # Gravity
	var v_x = distance.x / time  # Horizontal velocity
	var v_y = g * time / 2  # Vertical velocity (time/2 for reaching max height)
	
	# Combine horizontal and vertical velocity components to get the initial speed
	var initial_speed = sqrt(v_x * v_x + v_y * v_y)

	printt('distance', distance, time, v_x, v_y, launch_angle)
	
	# Return the velocity vector (v_x, v_y)
	# return Vector2(v_x*5, -v_y*5)  # Note: v_y is negative as it goes upward initially

	# Convert the launch angle to radians
	var theta = deg_to_rad(launch_angle)

	# Check if the vertical displacement affects the path
	var under_sqrt = (abs(distance.x) * tan(launch_angle) - distance.y)

	# Ensure under_sqrt doesn't go negative (to avoid math errors)
	printt(under_sqrt, abs(distance.x), tan(launch_angle), distance.y)
	if under_sqrt <= 0:
		print("Invalid conditions for the projectile to reach the target")
		return Vector2.ZERO
	

	# Calculate the required initial velocity to hit the target
	# var initial_velocity = sqrt((abs(distance.x) * gravity) / sin(2 * theta))
	var initial_velocity = abs(distance.x) / cos(launch_angle) * sqrt(gravity / (2 * under_sqrt))

	print_debug(initial_velocity, gravity)



	# Convert the velocity into a 2D vector (velocity components)
	velocity_x = initial_velocity if distance.x >= 0 else -initial_velocity * cos(theta)
	velocity_y = -initial_velocity * sin(theta)  # Negative because up is negative Y

	return Vector2(velocity_x, velocity_y)

# func compute_angle():
