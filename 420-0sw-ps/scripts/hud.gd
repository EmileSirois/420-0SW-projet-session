class_name HUD
extends CanvasLayer

@onready var captureMenu : Control = $CaptureMenu
@onready var book : Control = $Book

func _ready() -> void:
	captureMenu.hide()
	Events.capture_start.connect(capture_start)
	Events.capture_complete.connect(capture_end)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		book.visible = not book.visible
		get_tree().paused = book.visible

func pause() -> void:
	get_tree().paused = true

func resume() -> void:
	get_tree().paused = false

func capture_start() -> void:
	captureMenu.show()
	pause()

func capture_end() -> void:
	captureMenu.hide()
	resume()
