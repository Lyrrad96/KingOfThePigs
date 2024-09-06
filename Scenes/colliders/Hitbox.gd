extends Node

signal _damage_taken(hp)

@export var hp: int
@export var damage: int
@onready var attackCollision = $attackHitbox/attackCollision

@onready var bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.value = hp
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_attack_hitbox_area_entered(area:Area2D):
	print(area)

func attack():
	attackCollision.disabled = false
	# call_deferred("disable_attack")

func disable_attack():
	attackCollision.disabled = true


func _on_damage_hitbox_area_entered(area:Area2D) -> void:
	printt('hitbox', area, area.get_parent(), hp, area.get_parent().name)
	if area.get_parent().name == 'Hitbox':
		hp = hp - area.get_parent().damage
		bar.value = hp
		print(hp, bar, area.get_parent().damage)
	# _damage_taken.emit(hp)