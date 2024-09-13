extends State
class_name BombOffState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('BombOff')