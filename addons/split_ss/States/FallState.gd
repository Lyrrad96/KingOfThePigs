extends State
class_name FallState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

func update(_delta: float):
	super.update(_delta)
	var velocity = _par.velocity.y

	anim_player.play('Fall')
	printt('FallState', velocity)
	# anim_player.play('Ground')