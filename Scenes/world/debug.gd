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
	{
		'val': true,
		'list': [true, false],
		'var': 'king_run',
		'fun': 'king_run_tog',
		'nodes': ['king']
	},
	{
		'val': 'player',
		'list': ['player', 'king'],
		'var': 'cam',
		'fun': 'cam_tog',
		'nodes': ['player', 'king', 'cam']
	},
	{
		'val': Vector2.ZERO,
		'list': [Vector2(-54, 0), Vector2(191, 417), Vector2(191, 370)],
		'var': 'cannon',
		'fun': 'cannon_tog',
		'nodes': ['cannon']
	},
	{
		'val': 1.0,
		'list': [1.0, 2.0, 4.0],
		'var': 'zoom',
		'fun': 'zoom_tog',
		'nodes': []
	},
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
			# if not GameManager.debug_data.get(button.var):
			# 	GameManager.create_debug_var(button.var, button.list[0])
			button.val = GameManager.debug_data[button.var]
			# get(nodes[button.var].node).text = button.val
		printt(get(button.var), (button.var), button)
		get(button.var).connect("pressed", Callable(self, button.fun).bind(button))

	# restart.connect("pressed", get_tree().reload_current_scene)
	# king_run.connect("pressed", king_tog)
	# camb.connect("pressed", cam_tog)
	# cannon.connect("pressed", cannon_tog)
	# # king_run.connect("pressed", king.toggle_run)
	# king_run.text = 'K run ' + str(king.ikr)

	# zoom.connect("pressed", zoom_tog)
	# update_zoom(GameManager.debug_data['zoom'])

func restart_tog():
	get_tree().reload_current_scene()

func cannon_tog(button):
	printt(button, nodes[button.nodes[0]].node.position, button.list, button.val, button.list.find(Vector2(-54, 0)), button.list[(button.list.find(button.val)+1)%len(button.list)])
	button.val = button.list[(button.list.find(button.val)+1)%len(button.list)]
	nodes[button.nodes[0]].node.position = button.val
	GameManager.save_debug_var(button.var, button.val)

var cam_f = 'player'
func cam_tog(button):

	if button.val == 'player':
		nodes['player'].node.remove_child(nodes['cam'].node)
		nodes['king'].node.add_child(nodes['cam'].node)
		button.val = 'king'
	else:
		nodes['king'].node.remove_child(nodes['cam'].node)
		nodes['player'].node.add_child(nodes['cam'].node)
		button.val = 'player'

	GameManager.save_debug_var(button.var, button.val)


func zoom_tog(button):
	button.val = increment(button.list, button.val)
	GameManager.save_debug_var(button.var, button.val)

	update_zoom(button.val)

func update_zoom(z):
	nodes['cam'].node.zoom = Vector2(z, z)
	zoom.text = str(nodes['cam'].node.zoom.x) + 'x'

func king_run_tog(king):
	print_debug(king)
	king.toggle_run()
	king_run.text = 'K run ' + str(king.ikr)

func increment(list, val):
	return list[(list.find(val)+1)%len(list)]