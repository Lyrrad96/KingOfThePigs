extends State
class_name RunState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Run')