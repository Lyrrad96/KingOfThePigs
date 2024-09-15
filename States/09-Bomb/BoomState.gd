extends State
class_name BoomState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Boom')

	# if isNthFrame(-1):
	# 	_par.queue_free()