extends State
class_name BoooooomState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Boooooom')