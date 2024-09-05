@tool
extends Node
class_name AddChildNode

var button
func _enter_tree():
	preload("../reloader.gd").new()
	button = Button.new()
	printt('_enter_tree', button)
	# button.text = "busn"
	# button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# button.pressed.connect(add_child_node)
	# add_control_to_dock(DOCK_SLOT_RIGHT_UR, button)

func _exit_tree():
	printt('_exit_tree', button)
	# remove_control_from_docks(button) # Remove the dock
	# button.queue_free()
	button.free()

# func add_child_node(type, parent = get_editor_interface().get_selection().get_selected_nodes(), name = 'NewNode'):
func add_child_node(type, parent, name = 'NewNode'):
	# var selection := get_editor_interface().get_selection().get_selected_nodes()
	# printt(selection, selection.front(), '\n')
	# if selection.size() > 0:
	# var parent = selection.front()
	printt('add_child_node', type, parent)
	for child in parent.get_children():
		if child.name == name:
			printt(child.name == name, name)
			return child

	var node = type.new()
	# var node = Node.new()
	node.name = name #+ str(parent.get_child_count())
	parent.add_child(node)
	node.owner = get_scene_root(node)
	printt('owner', node, node.owner)
	# printt(parent, node, node.owner, parent.get_children(), get_tree().root.get_child(0), get_tree().get_current_scene(), parent.get_parent(), get_scene_root(node), '\n')
	return node

func get_scene_root(node: Node):
	var current_node = node
	while current_node.get_parent() != null:
		# If you have a specific way to determine a scene root, check it here
		if current_node is Node2D and not (current_node.get_parent() is Node2D):
			break
		current_node = current_node.get_parent()
	return current_node

# I am creating a new script like this:

# 	var script := GDScript.new()
# script.source_code = "extends State
# class_name "+state+"State
# func enter_state():
# 	var anim_player = self._par.find_children('*', 'AnimationPlayer')[0]
# 	anim_player.play('"+state+"')"
# var state_name = state + 'State'
# ResourceSaver.save(script, script_path)

# example saved file:
# extends State
# class_name AttackState
# func enter_state():
# 	var anim_player = self._par.find_children('*', 'AnimationPlayer')[0]
# 	anim_player.play('Attack')

# Instead of creating the node by using         var state_node = Node.new()
# I want to create a new child node of new type (AttackState)
# to loop it I will be doing 	var node = type.new()
# where type = AttackState
# I want a way to get all the classes or convert the string names of all the classes to be able to do this