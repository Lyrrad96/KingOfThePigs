extends State
class_name DieState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	printt(_fsm, anim_player)

func update(_delta: float):
	super.update(_delta)

	anim_player.play('Die')