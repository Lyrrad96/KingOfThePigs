extends State
class_name GroundState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Ground')