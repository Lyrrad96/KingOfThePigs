@tool
extends EditorPlugin

var plugin_id = "Split Spritesheet"  # Replace with your plugin's name

func _enter_tree():
    if Engine.is_editor_hint():
        reload_plugin()

func reload_plugin():
    var editor_interface = get_editor_interface()
    if editor_interface:
        var plugins = editor_interface.get_editor_plugins()
        for plugin in plugins:
            if plugin.plugin_name == plugin_id:
                plugin.set_enabled(false)
                await get_tree().create_timer(0.1).timeout
                plugin.set_enabled(true)
                printt("Plugin reloaded.")
                return
