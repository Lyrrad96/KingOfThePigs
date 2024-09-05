extends State
class_name IdleState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

var moving = false
var velocityX = 0
var velocityY = 0

func update(_delta: float):
	super.update(_delta)

	velocityX = _par.velocity.x
	velocityY = _par.velocity.y

	# printt('IdleState', _par, moving, velocityY, _par.velocity)
	if velocityX == 0:
		anim_player.play('Idle')
	else:
		anim_player.play('Run')