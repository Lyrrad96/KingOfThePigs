extends CanvasLayer

@onready var restart = $HBoxContainer/Restart
@onready var king_run = $HBoxContainer/kingRun
@onready var cam = $HBoxContainer/cam
@onready var zoom = $HBoxContainer/zoom
@onready var cannon = $HBoxContainer/cannon

# var player = null
# var king = null
# var cam = null

# var buttons = [
# 	'restart',
# 	'king_run',
# 	'cam',
# 	'cannon',
# 	'zoom',
# ]

var nodes = {
	'player': {
		'node': null,
		'node_path': 'Player',
	},
	'king': {
		'node': null,
		'node_path': 'King',
	},
	'cam': {
		'node': null,
		'node_path': 'Player/Camera2D',
	},
	'cannon': {
		'node': null,
		'node_path': 'Cannon2',
	},
}
var buttons = [
	{
		'var': 'restart',
		'fun': 'restart_tog'
	},
	# {
	# 	'val': true,
	# 	'list': [true, false],
	# 	'var': 'king_run',
	# 	'fun': 'king_run_tog',
	# 	'nodes': ['king']
	# },
	# {
	# 	'val': 'player',
	# 	'list': ['player', 'king'],
	# 	'var': 'cam',
	# 	'fun': 'cam_tog',
	# 	'nodes': ['player', 'king']
	# },
	{
		'val': Vector2.ZERO,
		'list': [Vector2(-54, 0), Vector2(191, 417), Vector2(191, 370)],
		'var': 'cannon',
		'fun': 'cannon_tog',
		'nodes': ['cannon']
	},
	# {
	# 	'val': 1.0,
	# 	'list': [1.0, 2.0, 4.0],
	# 	'var': 'zoom',
	# 	'fun': 'zoom_tog',
	# 	'nodes': []
	# },
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	await get_tree().create_timer(0.05).timeout

	for key in nodes:
		nodes[key].node = GameManager.mainScene.get_node(nodes[key].node_path)
		print_debug(key, nodes[key].node)

	# player = GameManager.mainScene.get_node('Player')
	# king = GameManager.mainScene.get_node('King')
	# cam = GameManager.mainScene.get_node('Player/Camera2D')

	for button in buttons:
		print_debug(button)
		if button.has('val'):
			if not GameManager.debug_data.get(button.var):
				GameManager.create_debug_var(button.var, button.list[0])
			button.val = GameManager.debug_data[button.var]
			# get(nodes[button.var].node).text = button.val
		printt(get(button.var), (button.var))
		get(button.var).connect("pressed", Callable(self, button.fun).bind(button))

	# restart.connect("pressed", get_tree().reload_current_scene)
	# king_run.connect("pressed", king_tog)
	# camb.connect("pressed", cam_tog)
	# cannon.connect("pressed", cannon_tog)
	# # king_run.connect("pressed", king.toggle_run)
	# king_run.text = 'K run ' + str(king.ikr)

	# zoom.connect("pressed", zoom_tog)
	# update_zoom(GameManager.debug_data['zoom'])

func cannon_tog(key, ind, list, node_list):
	printt(key, ind, list, node_list)
	node_list[0].position = list[(ind+1)%list.length]
	GameManager.save_debug_var(key, node_list[0].position)

var cam_f = 'player'
func cam_tog(key, ind, list, node_list):
	var player = nodes.player.node
	var king = nodes.king.node
	var active = GameManager.debug_data[key]

	node_list[list[ind]].node.remove_child(node_list[2])
	node_list[list[(ind+1)%2]].node.remove_child(node_list[2])

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

func zoom_tog(key, ind, list, node_list):
	# cam.zoom = Vector2(2, 2) if cam.zoom == Vector2(2, 2) else Vector2(4, 4)
	# var arr = [1.0, 2.0, 4.0]
	# var ind = (arr.find(GameManager.debug_data['zoom'])+1)%3
	var z = list[ind]
	GameManager.save_debug_var('zoom', z)

	update_zoom(z)

func update_zoom(z):
	cam.zoom = Vector2(z, z)
	zoom.text = str(cam.zoom.x) + 'x'

func king_tog(king):
	print_debug(king)
	king.toggle_run()
	king_run.text = 'K run ' + str(king.ikr)