extends State
class_name IdleStateCannon

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Idle')