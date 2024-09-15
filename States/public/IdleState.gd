extends State
class_name IdleState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Idle')
