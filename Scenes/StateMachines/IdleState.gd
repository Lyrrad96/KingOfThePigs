# IdleState.gd
extends State

class_name IdleState2

func enter(_data = {}):
    printt("Entering Idle State")

func exit():
    printt("Exiting Idle State")

func physics_process(delta):
    # Handle input and transitions here
    # if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
    #     state_machine.change_state("RunState")
    pass
