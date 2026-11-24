class_name MainMenu
extends Control

@onready var start_button : Button = %StartButton
@onready var options_button : Button = %OptionsButton
@onready var quit_button : Button = %QuitButton
@onready var options_menu : OptionsMenu = $OptionsMenu

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	options_menu.closed.connect(_on_options_closed)
	start_button.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_loop.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	options_menu.open()

func _on_options_closed() -> void:
	options_button.grab_focus()
