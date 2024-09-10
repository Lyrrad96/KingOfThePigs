extends State
class_name GroundState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

var velocityY = 0.0
func update(_delta: float):
	super.update(_delta)

	velocityY = _par.velocity.y

	anim_player.play('Ground')