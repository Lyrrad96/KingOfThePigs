extends CharacterBody2D

var speed = -100
var acc = -100
var throw_distance = -329 + 211
var max_height = -40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# velocity.x = speed
	# velocity.y = acc
	
	velocity = Vector2.ONE * get_parent().JUMP_VELOCITY

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# velocity.x = speed
	# velocity.y += gravity/4 * delta

	velocity.y += gravity * delta
	# velocity += Vector2.DOWN * gravity * delta
	rotation = velocity.angle()

	# move_and_collide(velocity)
	move_and_slide()

func get_path():
	var delta_position = final_position - initial_position
	var dx = delta_position.x
	var dy = delta_position.y

# angle = (1/2*sin^-1((gravity*distance)/projetilesvelocity^2)
# https://stackoverflow.com/questions/77248817/how-do-i-change-the-x-and-y-of-an-arch-texture-based-on-a-formula
# I want to make a projectile in godot 4 which follows a parabolic path
# how do I get the path if I know the initial and final position
