# @tool
extends Node2D

@onready var trajectory = $"."
@export var velocity_x = ''
@export var velocity_y = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	# print_debug(velocity_x, velocity_y)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_trajectory(delta)

@onready var line = $Line
var max_points = 250
func update_trajectory(delta):
	if not (get_parent().get(velocity_x) and get_parent().get(velocity_y)):
		printerr(get_parent(), velocity_x, get_parent().get(velocity_x), velocity_y, get_parent().get(velocity_y))
		return
	line.clear_points()
	var pos = trajectory.get_parent().global_position
	# print_debug(get_parent(), get_parent().get(velocity_x), get_parent().get(velocity_y))
	var vel = Vector2(get_parent().get(velocity_x), get_parent().get(velocity_y))
	for i in max_points:
		line.add_point(pos)
		vel.y += trajectory.get_parent().gravity * delta
		pos += vel * delta