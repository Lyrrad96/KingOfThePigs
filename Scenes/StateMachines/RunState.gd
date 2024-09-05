# RunState.gd
extends State

class_name RunState2

func enter(_data = {}):
    printt("Entering Run State")

func exit():
    printt("Exiting Run State")

func physics_process(_delta):
    # Handle input and transitions here
    # if Input.is_action_just_released("ui_right") and Input.is_action_just_released("ui_left"):
    #     state_machine.change_state("IdleState")
    pass
