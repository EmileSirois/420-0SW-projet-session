class_name HUD
extends CanvasLayer

@onready var captureButton : Button = %CapBtn
@onready var captureMenu : Control = $CaptureMenu

func _ready() -> void:
	captureMenu.hide()
	Events.capture_start.connect(capture_start)

func pause() -> void:
	get_tree().paused = true
	show()

func resume() -> void:
	get_tree().paused = false
	captureMenu.hide()
	hide()

func capture_start():
	captureMenu.show()
	pause()

func _on_cap_btn_pressed() -> void:
	Events.capture_complete.emit()
	captureMenu.hide()
	resume()
