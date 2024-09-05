# @tool
extends Node

@onready var trajectory = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	#printt(trajectory, trajectory.get_parent(), trajectory.get_parent().global_position, trajectory.get_parent().JUMP_VELOCITY, )
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if trajectory.get_parent().is_on_floor():
	if not Engine.is_editor_hint():
		update_trajectory(delta)

@onready var line = $Line
var max_points = 250
func update_trajectory(delta):
	line.clear_points()
	var pos = trajectory.get_parent().global_position
	var vel = Vector2(1, 1) * trajectory.get_parent().JUMP_VELOCITY
	#vel.x *= (-1 if player_sprite.flip_h else 1)
	#printt(pos, vel, global_transform)
	#printt(trajectory.get_parent().player_sprite.flip_h)
	#printt('\n')
	for i in max_points:
		# printt(pos, trajectory.get_parent().global_position, trajectory.get_parent().global_position.x-pos.x, delta, line.scale)
		line.add_point(pos)
		vel.y += trajectory.get_parent().gravity * delta
		pos += vel * delta
		#pos.x *= -trajectory.get_parent().direction
		#line.scale.y = -1 if trajectory.get_parent().player_sprite.flip_h else 1
		#pos.x += (abs(trajectory.get_parent().global_position.x-2*pos.x) if trajectory.get_parent().player_sprite.flip_h else 0)
		#if pos.y > $Ground.global_position.y - 25:
			#break
	#printt('\n')
