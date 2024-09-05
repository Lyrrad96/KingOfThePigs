extends Node

@onready var restart = $CanvasLayer/HBoxContainer/Restart
@onready var king_speed = $CanvasLayer/HBoxContainer/kingSpeed
@onready var camb = $CanvasLayer/HBoxContainer/cam

@onready var player = $Player
@onready var king = $King
@onready var cam = $Player/Camera2D

@onready var signpost = $Signs/Signpost

# Called when the node enters the scene tree for the first time.
func _ready():
	restart.connect("pressed", get_tree().reload_current_scene)
	king_speed.connect("pressed", set_stylebox_color)
	camb.connect("pressed", cam_tog)
	# king_speed.connect("pressed", king.toggle_speed)
	king_speed.text = 'K run ' + str(king.ikr)

	# signpost.find_child("Label", true).text = "z to attack"

var cam_f = 'player'
func cam_tog():
	printt(player, king)
	if cam_f == 'player':
		player.remove_child(cam)
		king.add_child(cam)
		cam_f = 'king'
		printt('player', player, king)
	else:
		king.remove_child(cam)
		player.add_child(cam)
		cam_f = 'player'
		printt('king', player, king)

func set_stylebox_color():
	
	king.toggle_speed()
	king_speed.text = 'K run ' + str(king.ikr)

	# printt(king.ikr, Color("#fff") if king.ikr else Color("#f41"))
	# king_speed.add_theme_color_override("font_color", Color("#fff") if king.ikr else Color("#f41"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_instance_valid(player):
		# if player and player.hp <= 0:
			# player.queue_free()
		if player:
			king.playerCoords(player.position)
