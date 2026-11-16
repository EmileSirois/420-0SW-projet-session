extends Control

func _on_cap_btn_pressed():
	Events.capture_complete.emit()
