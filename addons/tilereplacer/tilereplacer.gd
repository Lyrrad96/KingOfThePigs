@tool
extends EditorPlugin

const NODE_NAME = "NewTileMap"
const INHERITANCE = "TileMap"
const THE_SCRIPT = preload("CustomTileMap.gd")
var THE_ICON = get_editor_interface().get_base_control().get_theme_icon("TileMap", "EditorIcons")

func _enter_tree():
	preload("../reloader.gd").new()
	printt('_enter_tree', NODE_NAME)
	add_custom_type(NODE_NAME, INHERITANCE, THE_SCRIPT, THE_ICON)

func _exit_tree():
	printt('_exit_tree', NODE_NAME)
	remove_custom_type(NODE_NAME)