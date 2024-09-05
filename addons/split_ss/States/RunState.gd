extends State
class_name RunState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	printt(_fsm, anim_player)

var moving = false
func update(_delta: float):
	super.update(_delta)

	if _par.name == 'Player':
		printt(_par.direction, not _par.direction)
		if _par.direction:
			moving = true
		else:
			moving = false

	printt('RunState', _par, moving, anim_player.is_playing(), anim_player.current_animation, anim_player.current_animation != 'Run')
	anim_player.play('Run')