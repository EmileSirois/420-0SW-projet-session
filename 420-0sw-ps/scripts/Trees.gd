extends Node
class_name Trees

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var captureNode : bool = false

func _ready() -> void:
	sprite.play("default")  # nom de ton animation
	var frame_count : int = sprite.sprite_frames.get_frame_count(sprite.animation)
	sprite.frame = randi() % frame_count
	sprite.frame_progress = randf()

func renderCaptureClue():
	pass
