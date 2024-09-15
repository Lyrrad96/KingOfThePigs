extends State
class_name BombOnState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('BombOn')
