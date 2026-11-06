extends Node2D
class_name Interrior

@onready var interractionShape = %InterractionShape
var interracteable: bool = false
@export var spawnLocation : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") && interracteable):
		Events.scene_change.emit()

func _on_interraction_shape_body_entered(_body: Node2D) -> void:
	interracteable = true

func _on_interraction_shape_body_exited(_body: Node2D) -> void:
	interracteable = false
