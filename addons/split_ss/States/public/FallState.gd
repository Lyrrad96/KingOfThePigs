extends State
class_name FallState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Fall')