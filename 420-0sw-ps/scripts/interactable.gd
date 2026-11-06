extends Area2D
class_name Interactable

signal interacted

var inRange : bool = false

#Sprite 2d à surligner
@export var visual: CanvasItem   

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if visual and visual.material:
		visual.material = visual.material.duplicate()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		inRange = true
		_set_highlight(true)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		inRange = false
		_set_highlight(false)

func _unhandled_input(event: InputEvent) -> void:
	if inRange and event.is_action_pressed("Interact"):
		get_viewport().set_input_as_handled()
		interacted.emit()

func _set_highlight(on: bool) -> void:
	if visual and visual.material is ShaderMaterial:
		visual.material.set_shader_parameter("active", on)
