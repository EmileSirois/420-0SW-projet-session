extends Trees

func _ready() -> void:
	$Interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	Events.capture_start.emit()
