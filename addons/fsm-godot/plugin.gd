@tool
extends EditorPlugin
class_name NodeBasedFSM

const Convertor = preload("scripts/AddChild.gd")
# const Convertor = preload("scripts/InspectorConvertor2.gd")

var plugin: Convertor

func _enter_tree():

    preload("../reloader.gd").new()

    print('_enter_tree FSM')

    add_custom_type("FiniteStateMachine", "Node", preload("res://addons/fsm-godot/scripts/finite_state_machine.gd"), preload("res://addons/fsm-godot/icons/fsm.png"))
    add_custom_type("State", "Node", preload("res://addons/fsm-godot/scripts/state.gd"), preload("res://addons/fsm-godot/icons/state.png"))
    add_custom_type("Transition", "Node", preload("res://addons/fsm-godot/scripts/transition.gd"), preload("res://addons/fsm-godot/icons/transition.png"))

    plugin = Convertor.new()
    # plugin.animation_updated.connect(_refresh, CONNECT_DEFERRED)
    add_inspector_plugin(plugin)

func _exit_tree():
    print('_exit_tree FSM')

    remove_custom_type("FiniteStateMachine")
    remove_custom_type("State")
    remove_custom_type("Transition")

    remove_inspector_plugin(plugin)