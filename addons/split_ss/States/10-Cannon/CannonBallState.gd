extends State
class_name CannonBallState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('CannonBall')