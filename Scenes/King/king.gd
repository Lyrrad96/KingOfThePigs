extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var king = $"."

@export var speed = 60
const JUMP_VELOCITY = -400.0

const BUFFER =10

var hp = 200

@onready var anim_player = $animPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var wall_detector_v = $wallDetectorV
@onready var wall_detector_h = $wallDetectorH
@onready var wall_detector_jump = $wallDetectorJump
@onready var label = $Label


var ikr = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	# game_manager.load_debug()
	ikr = game_manager.debug_data.isKingRunning
	speed = 60 if ikr else 0

var facing_right = 1
var jumping = false
func _physics_process(delta):
	if game_manager.dead:
		return
	label.text = str(hp)
	label.scale.x = facing_right
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		jumping = true
	else:
		jumping = false

	var mustflip = chaseX()
	var mustjump = chaseY()

	if wall_detector_h.is_colliding() and wall_detector_h.get_collider().name == "Player":
		attack()
	elif mustjump and wall_detector_jump.is_colliding() and is_on_floor():
		jump()
		mustjump = false
	elif mustflip:
		flip()
	
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = speed
	
	update_animation()
	
	#line.show()
	#update_trajectory(delta)
	
	move_and_slide()

func flip():
	facing_right *= -1
	scale.x *= -1
	speed = abs(speed) * facing_right

	wall_detector_h.scale.y = wall_detector_h.scale.y * facing_right

func jump():
	# Handle jump.
	velocity.y = JUMP_VELOCITY


@export var hit = false
func update_animation():
	if hp <= 0:
		anim_player.play("Die")
	# elif attacking:
	# 	anim_player.play("Attack")
	elif hit:
		anim_player.play("Hit")
	elif velocity.y < 0:
		anim_player.play("Jump")
	elif velocity.x:
		anim_player.play("Run")
	else:
		anim_player.play("Idle")

func hurt():
	anim_player.play("Hit")

func die():
	#printt("died")
	anim_player.play("Hit")
	hp-=10

@export var attacking = false

@onready var attack_hitbox = $attackHitbox

func attack():
	attacking = true
	var overlapping_objects = attack_hitbox.get_overlapping_areas()
	# printt(overlapping_objects)
	for obj in overlapping_objects:
		var _parent = obj.get_parent()
		# _parent.attacked()
		#parent.queue_free()
		game_manager.attack_calc(_parent)

func _on_attack_hitbox_area_entered(area):
	if area.name == "damageHitbox" and area.get_parent().name == "Player":
		area.get_parent().die()

var player = Vector2(0, 0)
func playerCoords(coords):
	# printt(coords)
	player = coords
	#printt(coords, position)
	#if (coords.x>position.x and facing_right == -1) or (coords.x<position.x and facing_right == 1):
		#flip()

func chaseX():
	#printt(get_stack()[0].line, " ", player.x, position.x)
	
	# direction
	if abs(player.x - position.x) < BUFFER:
		return false
	elif player.x > position.x and facing_right == -1:
		return true
	elif player.x < position.x and facing_right == 1:
		return true
	

func chaseY():
	# printt(get_stack()[0].line, " ", player.y, position.y, '|', abs(player.y - position.y), abs(player.y - position.y) < BUFFER)
	# jump
	if abs(player.y - position.y) < BUFFER:
	# if player.y != position.y:
		return false
	else:
		return true

func toggle_run():
	# king.set_meta('speed', !king.get_meta('speed'))
	ikr = !ikr
	speed = 60 if ikr else 0
	game_manager.save_debug('isKingRunning', ikr)
