extends State
class_name Cannon_bodyState

var shot = false
func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Cannon_body')

	# print(floor(_par.animation_player.get_current_animation_position()*5))
	if isNthFrame(1) and not shot:
		# printt('launch', )
		shot = true
		_par.launch()
	if isNthFrame(-1):
		_par.must_shoot = false
		shot = false