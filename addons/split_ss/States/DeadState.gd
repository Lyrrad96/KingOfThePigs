extends State
class_name DeadState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

var hp = 0
func update(_delta: float):
	super.update(_delta)

	hp = _par.hp
	printt('hp', hp)

	anim_player.play('Dead')