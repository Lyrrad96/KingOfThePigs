extends State
class_name HitState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Hit')