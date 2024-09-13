extends Node

signal _damage_taken(hp)

@onready var attackCollision = $attackHitbox/attackCollision
@onready var _par : = get_parent()

@onready var bar = $ProgressBar

var knock_atk = Vector2.ZERO
var knock_def = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# hp = get_parent().hp
	printt('get_parent', get_parent(), get_parent().hp)
	bar.value = _par.hp
	bar.max_value = _par.hp
	# print(hp, bar.max_value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ProgressBar.scale.x = self.scale.x

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
	printt('hitbox', area, area.get_parent(), _par.hp, area.get_parent().name, area.get_parent().get('damage'), _par.velocity)
	var atk
	if area.get_parent().name == 'Hitbox':
		atk = area.get_parent()._par
	elif area.get('damage'):
		atk = area
	else:
		return

	print(_par.velocity)
	
	_par.hp = _par.hp - atk.damage
	bar.value = _par.hp
	_par.label.text = str(_par.hp)
	_par.isHit = true
	knockback(atk)
	# _damage_taken.emit(hp

func knockback(atk):
	var pos = _par.position - atk.position
	_par.hitbox.knock_def.x = atk.knock_atk.x * (1 if pos.x > 0 else -1)
	# pos.x
	_par.hitbox.knock_def.y = atk.knock_atk.y * (1 if pos.y > 0 else -1)
	#  pos.y
	_par.velocity = _par.hitbox.knock_def
	printt(_par.position, atk.position, pos, _par.velocity, atk.knock_atk, _par.hitbox.knock_def)