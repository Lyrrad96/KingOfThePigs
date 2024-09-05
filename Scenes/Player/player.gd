extends CharacterBody2D

@onready var game_manager = %GameManager

@onready var animation_player = $AnimationPlayer
@onready var player_sprite = $playerSprite
@onready var attack_hitbox = $attackHitbox

const SPEED = 160.0
const JUMP_VELOCITY = -400.0

var hp = 100

@export var attacking = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var label = $Label
@onready var healthbar = $ProgressBar
@onready var state_machine = StateMachine.new()

func _ready():
	label.text = str(hp)
	healthbar.max_value = hp
	#button.connect("pressed", update_trajectory)


var direction = 1
var facing_right = 1

var velocityX
var velocityY

func _physics_process(delta):

	healthbar.value = hp

	if(hp<=0):
		label.text = 'hekkin died'
		game_manager.dead = true
		return
	
	label.text = str(hp)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Attack"):
		attack()
	
	direction = Input.get_axis("Run Left", "Run Right")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
		# printt(direction, scale.x, scale, direction == scale.x)
		# attack_hitbox.position.x *= -1
		# scale = Vector2(-direction, 1)
		# scale.y = abs(scale.y)
		# if direction != scale.x:
		# 	# flip(direction)
		# 	# scale.x = direction
		# 	scale.x = scale.x * -1
		# 	printt(scale)
		player_sprite.flip_h = true if direction == 1 else false
		# if player_sprite.flip_h and attack_hitbox.get_child(0).scale.x == 1:
		attack_hitbox.position.x = 8 if direction == 1 else -8
		# elif direction<0 and scale.x == -1:
		# 	scale.x = 1#abs(scale.x)
		# 	player_sprite.flip_h = false
		# 	attack_hitbox.get_child(0).scale.x = 1
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# update_animation()
	
	#line.show()
	#if not is_on_floor():
		#update_trajectory(delta)
	
	move_and_slide()

	velocityX = velocity.x
	velocityY = velocity.y

# func flip(d):
# 	scale.x *= -1
# 	printt(scale.x)

# func update_animation():
# 	printt(animation_player.get_current_animation())
	# if !animation_player.get_current_animation():
	# if hp == 0:
	# 	game_manager.die(get_tree())
		# queue_free()
		# animation_player.play("Dead")
	# if attacking:
	# 	animation_player.play("Attack")
	# elif hit:
	# 	animation_player.play("Hit")
	# elif velocity.y < 0:
	# 	animation_player.play("Jump")
	# elif velocity.x:
	# 	animation_player.play("Run")
	# else:
	# 	animation_player.play("Idle")

func attack():
	attacking = true
	var overlapping_objects = attack_hitbox.get_overlapping_areas()
	#printt(overlapping_objects)
	for obj in overlapping_objects:
		var _parent = obj.get_parent()
		#parent.attacked()
		#parent.queue_free()
		#printt(obj, parent)
	#animation_player.play("Attack")


# @onready var button = $Button

@export var hit = false
func die():
	#printt("died")
	hit = true
	animation_player.play("Hit")
	hp-=10

func _on_attack_hitbox_area_entered(area):
	printt("area: ", area, area.get_parent().name)
	if area.name == "damageHitbox" and area.get_parent().name == "King":
		area.get_parent().die()


func _on_damage_hitbox_area_entered(area:Area2D):
	printt("_on_damage_hitbox_area_entered: ", area, area.get_parent().name)
	pass # Replace with function body.
