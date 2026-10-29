class_name Player
extends CharacterBody2D

@onready var animPlayer : AnimationPlayer = $AnimationPlayer
const SPEED = 60.0
var last_pressed : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var facing : String = "Down"
	
	if direction:
		facing = get_facing(direction)
		animPlayer.play(facing + "Walk")
		velocity = direction * SPEED
	else:
		velocity = Vector2(0, 0)
		animPlayer.stop()
	
	move_and_slide()

func get_facing(dir: Vector2) -> String:
	if abs(dir.x) > abs(dir.y):
		return "Right" if dir.x > 0 else "Left"
	else:
		return "Down" if dir.y > 0 else "Up"

func _input(event):
	var pressed : Vector2
	
	if event.is_action_pressed("Left"):
		last_pressed = Vector2.LEFT
	elif event.is_action_pressed("Right"):
		last_pressed = Vector2.RIGHT
	elif event.is_action_pressed("Up"):
		last_pressed = Vector2.UP
	elif event.is_action_pressed("Down"):
		last_pressed = Vector2.DOWN
	
	var raw : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	if raw == Vector2.ZERO:
		direction = Vector2.ZERO
	elif raw.x != 0 and raw.y != 0:
		direction = last_pressed          # diagonale : la plus récente gagne
	else:
		direction = Vector2(sign(raw.x), sign(raw.y))
