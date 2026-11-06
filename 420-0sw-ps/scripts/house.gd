extends Node2D

func _ready() -> void:
	$Interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	Events.scene_change.emit()
