extends Area2D

var game_manager = preload("res://Scenes/world/GameManager.gd").new()
@export var damage = 0
@export var knock_atk = Vector2.ZERO
@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AutoAnimatedSprite2D.play("BombOn")

# func _physics_process(delta: float) -> void:
# 	print($AutoAnimatedSprite2D.animation_looped())

# 	# print(game_manager.isNthFrame($AnimationPlayer, -1))
# 	if game_manager.isNthFrame($AnimationPlayer, -1):
# 		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print('body', body)
enum states {ON, OFF, EXPLODE}
@export var state = states.ON

func _on_area_entered(area: Area2D) -> void:
	print('area', area, state)
	state = states.EXPLODE