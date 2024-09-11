extends State
class_name JumpState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Jump')