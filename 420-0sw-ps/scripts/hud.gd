class_name HUD
extends CanvasLayer

@onready var captureMenu : Control = $CaptureMenu
@onready var book : Control = $Book

func _ready() -> void:
	captureMenu.hide()
	Events.capture_start.connect(capture_start)
	Events.capture_complete.connect(capture_end)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		book.visible = !book.visible
		if book.visible:
			pause()
		else:
			resume()

func pause() -> void:
	get_tree().paused = true
	show()

func resume() -> void:
	get_tree().paused = false
	hide()

func capture_start():
	captureMenu.show()
	pause()

func capture_end() -> void:
	captureMenu.hide()
	resume()
