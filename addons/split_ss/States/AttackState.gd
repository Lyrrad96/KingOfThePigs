extends State
class_name AttackState
var anim_player
func enter_state():
	anim_player = _par.find_children('*', 'AnimationPlayer')[0]
	# printt(_fsm, anim_player)

var attack = false
func update(_delta: float):
	super.update(_delta)

	attack = _par.isAttacking

	anim_player.play('Attack')