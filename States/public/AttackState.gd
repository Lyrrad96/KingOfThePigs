extends State
class_name AttackState

var anim_length
var threshold = 0.02

func enter_state():
	anim_length = _par.animation_player.get_animation("Attack").length

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Attack')

	if isNthFrame(-1):
		_par.mustAttack = false

	if isNthFrame(2):
		_par.hitbox.attackCollision.disabled = false
	else:
		_par.hitbox.attackCollision.disabled = true
