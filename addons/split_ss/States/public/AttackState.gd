extends State
class_name AttackState

var anim_length
var threshold = 0.02

func enter_state():
	anim_length = _par.animation_player.get_animation("Attack").length

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Attack')

	if isLastFrame():
		_par.mustAttack = false
	
	if isThirdFrame():
		_par.hitbox.attackCollision.disabled = false
	else:
		_par.hitbox.attackCollision.disabled = true

func isThirdFrame():
	return floor(_par.animation_player.get_current_animation_position()*5) == 3

func isLastFrame():
	return floor(_par.animation_player.get_current_animation_position()*5) == _par.animation_player.get_current_animation_length()*5 - 1