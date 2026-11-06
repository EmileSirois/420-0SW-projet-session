extends Node2D
class_name Interrior

@export var spawnLocation : Vector2

func _ready() -> void:
	$Interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	Events.scene_change.emit()
