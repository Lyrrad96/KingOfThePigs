extends CharacterBody2D

@onready var game_manager = %GameManager

@onready var animation_player = $AnimationPlayer
@onready var player_sprite = $playerSprite
# @onready var attack_hitbox = $attackHitbox
@onready var hitbox = $Hitbox
# var damage = hitbox.damage

const SPEED = 160.0
const JUMP_VELOCITY = -400.0

var hp: int = 0
var damage: int = 0
@export var mustAttack = false
var stats = preload("res://Scenes/Player/stats.tres")
@export var attributes: CharStats:
	set(value):
		attributes = value
		hp = value.hp
		damage = value.damage

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var label = $Label
@onready var healthbar = $ProgressBar

func _ready():
	printt('attributes', attributes, hp, damage, game_manager)
	# hp = stats.hp
	# damage = stats.damage
	label.text = str(hp)
	print(hp)

	# healthbar.max_value = hp
	#button.connect("pressed", update_trajectory)

var direction = 1
var facing_right = 1

var velocityX
var velocityY

func _physics_process(delta):
	# hp = stats.hp
	# damage = stats.damage

	# healthbar.value = hp

	# if(hp<=0):
	# 	label.text = 'hekkin died'
	# 	game_manager.dead = true
	# 	return

	# label.text = str(hp)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Attack"):
		# hitbox.attack(delta)
		mustAttack = true
		# attack()
	
	direction = Input.get_axis("Run Left", "Run Right")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
		# printt(direction, scale.x, scale, direction == scale.x)
		# attack_hitbox.position.x *= -1
		# scale = Vector2(-direction, 1)
		# scale.y = abs(scale.y)
		# if direction == scale.x:
		# 	print(direction == scale.x)
		# else:
		# # 	# flip(direction)
		# 	scale.x *= -1
		# 	# scale.x = sign(velocity.x) * abs(scale.x)
		# 	printt('flip', direction, scale.x)
			# scale.x = scale.x * direction
		# 	scale.x = scale.x * -1
		# print(scale.x, '"', direction, '"', direction == scale.x, type_string(typeof(scale.x)), '"', type_string(typeof(direction)), '"', velocity.x)
		player_sprite.flip_h = true if direction == 1 else false
		hitbox.scale.x = -1 if direction == 1 else 1
		# if player_sprite.flip_h and attack_hitbox.get_child(0).scale.x == 1:
		# attack_hitbox.position.x = 8 if direction == 1 else -8
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
	# if mustAttack:
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
	mustAttack = true
	# var overlapping_objects = attack_hitbox.get_overlapping_areas()
	# #printt(overlapping_objects)
	# for obj in overlapping_objects:
	# 	var _parent = obj.get_parent()
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
	# hp-=10

# func _on_attack_hitbox_area_entered(area):
# 	printt("area: ", area, area.get_parent().name)
# 	if area.name == "damageHitbox" and area.get_parent().name == "King":
# 		area.get_parent().die()


# func _on_damage_hitbox_area_entered(area:Area2D):
# 	printt("_on_damage_hitbox_area_entered: ", area, area.get_parent().name)
# 	pass # Replace with function body.


# func _on_hitbox__damage_taken(hp: Variant) -> void:
# 	pass # Replace with function body.
