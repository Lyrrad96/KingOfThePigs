extends Node2D

@onready var wall_detector_v = $wallDetectorV
@onready var wall_detector_h = $wallDetectorH
@onready var wall_detector_jump = $wallDetectorJump

signal collision(d)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var turn = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if wall_detector_h.is_colliding() or not wall_detector_v.is_colliding():
		printt(wall_detector_h.is_colliding(), wall_detector_v.is_colliding())
		# collision.emit('h')
		flip()
		turn = true
	# else:
	# 	turn = false
	print(turn)
	# if not wall_detector_v.is_colliding():
	# 	print(wall_detector_v)
	# 	# collision.emit('v')
	# 	turn = true
	
	# if wall_detector_jump.is_colliding():
	# 	print(wall_detector_jump)
	# 	collision.emit('jump')

func flip():
	collision.emit('h')
	turn = false