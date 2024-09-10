@tool
extends EditorPlugin

# const NODE_NAME = "LabelButton"
# const INHERITANCE = "Button"
# const THE_SCRIPT = preload("label_button.gd")
# const THE_ICON = preload("res://Sprites/Touchscreen/fist.png")


# const NODE_NAME = "SliceableAnimatedSprite2D"
const NODE_NAME = "AutoAnimatedSprite2D"
const INHERITANCE = "AnimatedSprite2D"
const THE_SCRIPT = preload("AutoAnimatedSprite2D.gd")
var THE_ICON = get_editor_interface().get_base_control().get_theme_icon("AnimatedSprite2D", "EditorIcons")

const ConvertorA2D = preload("./GenerateAnimation.gd")

var pluginA2D: ConvertorA2D

# const ConvertorAP = preload("res://addons/split_ss/InspectorConvertor.gd")

# var pluginAP: ConvertorA2D

func _enter_tree():
	preload("../reloader.gd").new()
	printt('_enter_tree', NODE_NAME)
	add_custom_type(NODE_NAME, INHERITANCE, THE_SCRIPT, THE_ICON)

	# var a = AddChildNode.new()
	# a.add_child_node(AnimationPlayer, get_parent())

	pluginA2D = ConvertorA2D.new()
	# pluginA2D.animation_updated.connect(_refresh, CONNECT_DEFERRED)
	add_inspector_plugin(pluginA2D)
	
	# pluginAP = ConvertorA2D.new()
	# add_inspector_plugin(pluginAP)

func _refresh(anim_player):
	var interface = get_editor_interface()

	# Hacky way to force the editor to deselect and reselect the animation panel, as the panel won't update until then
	interface.inspect_object(interface.get_edited_scene_root())
	interface.get_selection().clear()
	await get_tree().create_timer(0.05).timeout
	interface.inspect_object(anim_player)

func _exit_tree():
	printt('_exit_tree', NODE_NAME)
	remove_custom_type(NODE_NAME)

	remove_inspector_plugin(pluginA2D)
	# remove_inspector_plugin(pluginAP)