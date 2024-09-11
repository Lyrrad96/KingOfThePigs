extends State
class_name IdleState

func update(_delta: float):
	super.update(_delta)

	_par.animation_player.play('Idle')

	# _par.game_manager.get_anim_frame(_par.animation_player, 'Attack', -1 ,_delta)

	# printt(_delta, _par.animation_player.get_current_animation_length(), _par.animation_player.get_current_animation_length()/(_delta), _par.game_manager.get_anim_frame(_par.animation_player, 'Attack', -1), _par.game_manager.get_anim_frame(_par.animation_player, 'Attack', 0), _par.game_manager.get_anim_frame(_par.animation_player, 'Attack', 1))
	# if(_par.name == 'Player'):
	# 	printt(snapped(_par.animation_player.get_current_animation_position(), 0.0001), _par.animation_player.get_current_animation_length(), _par.animation_player.get_current_animation_length()*5-1, floor(_par.animation_player.get_current_animation_position()*5))
