extends Area2D

# Export the hint message and the path to the hint label scene
@onready var label = $Label
@export var text = ''

func _ready() -> void:
	label.visible = false
	label.text = text
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":  # Replace with the actual name of your player node
		if label:
			label.visible = true

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":  # Replace with the actual name of your player node
		label.visible = false
