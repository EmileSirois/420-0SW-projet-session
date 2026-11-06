extends Node2D

@onready var interractionShape = $InterractionShape
var interracteable: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") && interracteable):
		Events.scene_change.emit()

func _on_interraction_shape_body_entered(_body: Node2D) -> void:
	interracteable = true

func _on_interraction_shape_body_exited(_body: Node2D) -> void:
	interracteable = false
