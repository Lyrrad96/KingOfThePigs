extends Area2D

@export var damage = 40
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$sprite.play("BombOn")

# func _on_body_entered(body: Node2D) -> void:
# 	print_debug(body)
# 	if body.name == "Player":
# 		$AutoAnimatedSprite2D.play("Boooooom")
# 		# $Timer.start()

func _on_area_entered(area: Area2D) -> void:
	print_debug(area)
	# if body.name == "Player":
	$sprite.play("Boooooom")
	$damage.disabled = false
		# $Timer.start()