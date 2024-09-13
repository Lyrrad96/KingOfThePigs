extends State
class_name ShootState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Shoot')