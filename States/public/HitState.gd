extends State
class_name HitState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Hit')

	# _par.velocity = -_par.hitbox.knockback
	# printt(_par.velocity, _par.velocity.x == 0)
	_par.velocity.x += 10

	if isNthFrame(-1):
	# await get_tree().create_timer(1).timeout
	# if _par.velocity.x == 0:
		_par.isHit = false