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
# var stats = preload("res://Scenes/Player/stats.tres")
@export var attributes: CharStats:
	set(value):
		attributes = value
		hp = value.hp
		damage = value.damage

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var label = $Label
@onready var healthbar = $ProgressBar

var flippable = [player_sprite, hitbox]
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

	if(hp<=0) and is_on_floor():
	# 	label.text = 'hekkin died'
	# 	game_manager.dead = true
		return

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
	if not isHit:
		if direction:
			velocity.x = direction * SPEED

			player_sprite.flip_h = true if direction == 1 else false
			hitbox.scale.x = -direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	velocityX = velocity.x
	velocityY = velocity.y

@export var isHit = false
func die():
	#printt("died")
	isHit = true
	animation_player.play("Hit")
	# hp-=10
