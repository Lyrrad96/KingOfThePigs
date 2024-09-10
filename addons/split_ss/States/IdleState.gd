extends State
class_name IdleState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

var direction = 0
var hp = 0
var attack = false
var velocityY = 0.0

func update(_delta: float):
	super.update(_delta)

	direction = _par.direction
	hp = _par.hp
	attack = _par.isAttacking
	velocityY = _par.velocity.y

	print(direction)
	if direction:
		anim_player.play('Run')
	else:
		anim_player.play('Idle')