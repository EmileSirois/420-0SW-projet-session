extends Trees

@onready var sparkle: AnimatedSprite2D = $Sparkle
@onready var interactable: Interactable = $Interactable

var capturable := false:
	set(value):
		capturable = value
		if is_node_ready():
			_update_sparkle()

func _ready() -> void:
	add_to_group("trees")
	interactable.interacted.connect(_on_interacted)
	randomize_frames()
	_update_sparkle()

func _update_sparkle() -> void:
	sparkle.visible = capturable
	if capturable:
		# décale l'animation pour que les arbres ne scintillent pas en synchro
		sparkle.frame = randi() % sparkle.sprite_frames.get_frame_count(sparkle.animation)
		sparkle.play()
	else:
		sparkle.stop()

func _on_interacted() -> void:
	if not capturable:
		return
	if not Events.capture_complete.is_connected(_on_capture_complete):
		Events.capture_complete.connect(_on_capture_complete, CONNECT_ONE_SHOT)
	Events.capture_start.emit()

func _on_capture_complete() -> void:
	capturable = false
