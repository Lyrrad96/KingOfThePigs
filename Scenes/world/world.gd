extends Node

@onready var restart = $CanvasLayer/HBoxContainer/Restart
@onready var king_speed = $CanvasLayer/HBoxContainer/kingSpeed
@onready var camb = $CanvasLayer/HBoxContainer/cam
@onready var zoom = $CanvasLayer/HBoxContainer/zoom
@onready var cannonb = $CanvasLayer/HBoxContainer/cannonb

@onready var player = $Player
@onready var king = $King
@onready var cam = $Player/Camera2D

@onready var signpost = $Signs/Signpost

@onready var game_manager = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	# restart.connect("pressed", get_tree().reload_current_scene)
	# king_speed.connect("pressed", king_tog)
	# camb.connect("pressed", cam_tog)
	# cannonb.connect("pressed", cannon_tog)
	# # king_speed.connect("pressed", king.toggle_speed)
	# king_speed.text = 'K run ' + str(king.ikr)

	# zoom.connect("pressed", zoom_tog)
	# update_zoom(game_manager.debug_data['zoom'])

	GameManager.mainScene = $"."
	GameManager.player = $Player

	# signpost.find_child("Label", true).text = "z to attack"
func cannon_tog():
	$Cannon2.position = Vector2(191, 417) if $Cannon2.position != Vector2(191, 417) else Vector2(191, 370)

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

func zoom_tog():
	# cam.zoom = Vector2(2, 2) if cam.zoom == Vector2(2, 2) else Vector2(4, 4)
	var arr = [1.0, 2.0, 4.0]
	var ind = (arr.find(game_manager.debug_data['zoom'])+1)%3
	var z = arr[ind]
	game_manager.save_debug_var('zoom', z)

	update_zoom(z)

func update_zoom(z):
	cam.zoom = Vector2(z, z)
	zoom.text = str(cam.zoom.x) + 'x'

func king_tog():

	king.toggle_speed()
	king_speed.text = 'K run ' + str(king.ikr)

	# printt(king.ikr, Color("#fff") if king.ikr else Color("#f41"))
	# king_speed.add_theme_color_override("font_color", Color("#fff") if king.ikr else Color("#f41"))

# func _on_player_shoot(Bullet, direction, location):
# 	var spawned_bullet = Bullet.instantiate()
# 	add_child(spawned_bullet)
# 	spawned_bullet.rotation = direction
# 	spawned_bullet.position = location
# 	spawned_bullet.velocity = spawned_bullet.velocity.rotated(direction)

# func _on_cannon_2_shoot(bullet:Variant, direction:Variant, location:Variant) -> void:
# 	var spawned_bullet = bullet.instantiate()
# 	add_child(spawned_bullet)
# 	spawned_bullet.rotation = direction
# 	spawned_bullet.position = location
# 	spawned_bullet.linear_velocity = spawned_bullet.linear_velocity.rotated(direction)