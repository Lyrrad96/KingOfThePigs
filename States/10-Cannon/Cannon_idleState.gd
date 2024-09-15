extends State
class_name Cannon_idleState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Cannon_idle')