extends State
class_name DeadState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Dead')

	if isLastFrame():
		_par.animation_player.pause()

func isLastFrame():
	return floor(_par.animation_player.get_current_animation_position()*5) == floor(_par.animation_player.get_current_animation_length()*5 - 1)