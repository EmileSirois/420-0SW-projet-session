extends Trees

@onready var interractionShape = $InterractionShape
var interracteable: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") && interracteable:
		print("Insect capture", self)

func _on_interraction_shape_body_entered(body: Node2D) -> void:
	if body is Player:
		interracteable = true

func _on_interraction_shape_body_exited(body: Node2D) -> void:
	if body is Player: 
		interracteable = false
