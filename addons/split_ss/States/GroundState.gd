extends State
class_name GroundState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	printt(_fsm, anim_player)

var Ground_var
func update(_delta: float):
	super.update(_delta)

	anim_player.play('Ground')