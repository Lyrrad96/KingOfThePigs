extends CharacterBody2D

const SPEED = 30.0
const JUMP_VELOCITY = -400.0
@onready var label = $Label
@onready var wallDetector = $wallDetector

@onready var wall_detector_v = $wallDetectorV
@onready var wall_detector_h = $wallDetectorH
@onready var hitbox = $Hitbox

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1
var hp
var velocityX
var velocityY
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# label.text = str(hp)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#Input.get_axis("ui_left", "ui_right")
	printt(wallDetector, wallDetector.turn)
	hp = hitbox.hp
	velocityX = velocity.x
	velocityY = velocity.y

	if wall_detector_h.is_colliding() and wall_detector_h.get_collider().name == "Player":
		attack()
	elif wall_detector_h.is_colliding() and wall_detector_h.get_collider().name == "Player":
		flip()

	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# if wallDetector.turn:
	# 	print(direction)
	# 	# flip()
	# 	direction *= -1
	# 	scale.x*=-1
	# 	return
	# 	# wallDetector.turn = false

func flip():
	# facing_right *= -1
	scale.x *= -1
	direction *= -1
	# speed = abs(speed) * facing_right


var attacking = false
func attack():
	attacking = true
	# var overlapping_objects = attack_hitbox.get_overlapping_areas()
	# # printt(overlapping_objects)
	# for obj in overlapping_objects:
	# 	var _parent = obj.get_parent()
	# 	# _parent.attacked()
	# 	#parent.queue_free()
	# 	game_manager.attack_calc(_parent)


# 	wall_detector_h.scale.y = wall_detector_h.scale.y * facing_right

func _on_wall_detector_collision(d) -> void:
	print('wall', d)
	direction *= -1
