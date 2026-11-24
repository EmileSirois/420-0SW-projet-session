class_name OptionsMenu
extends Control

signal closed

@onready var volume_slider : HSlider = %VolumeSlider
@onready var back_button : Button = %BackButton

var master_bus : int = AudioServer.get_bus_index("Master")

func _ready() -> void:
	volume_slider.value_changed.connect(_on_volume_changed)
	back_button.pressed.connect(_on_back_pressed)

func open() -> void:
	show()
	volume_slider.grab_focus()

func _on_volume_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))

func _on_back_pressed() -> void:
	hide()
	closed.emit()
