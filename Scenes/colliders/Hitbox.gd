extends Node

signal _damage_taken(hp)

@onready var attackCollision = $attackHitbox/attackCollision

@onready var bar = $ProgressBar
var hp = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	# hp = get_parent().hp
	printt('get_parent', get_parent(), get_parent().hp)
	bar.value = hp
	bar.max_value = hp
	# print(hp, bar.max_value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_attack_hitbox_area_entered(area:Area2D):
	print(area)

func attack(delta):
	attackCollision.disabled = false
	print(1, delta)
	await get_tree().create_timer(delta*2).timeout
	print(2)
	# attackCollision.disabled = true
	call_deferred("disable_attack")

func disable_attack():
	attackCollision.disabled = true

func _on_damage_hitbox_area_entered(area:Area2D) -> void:
	printt('hitbox', area, area.get_parent(), hp, area.get_parent().name)
	if area.get_parent().name == 'Hitbox':
		hp = hp - area.get_parent().damage
		bar.value = hp
		printt(hp, bar, area.get_parent().damage)
	# _damage_taken.emit(hp)