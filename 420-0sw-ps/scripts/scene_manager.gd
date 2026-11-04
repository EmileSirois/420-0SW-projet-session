extends Node

@onready var sceneContainer = $"../SceneContainer"
@onready var player = $"../Player"
@export var houseScene : PackedScene
@export var worldScene : PackedScene
var currentScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.scene_change.connect(_on_scene_switch)
	
	currentScene = worldScene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_scene_switch():
	currentScene = sceneContainer.get_child(0)
	sceneContainer.queue_free()
	
	if(currentScene is World):
		currentScene = houseScene
	elif(currentScene is Interrior):
		currentScene = worldScene
	
	var current = currentScene.instantiate()
	var spawn : Vector2 = current.spawnLocation
	
	player.position = spawn
	
	sceneContainer.add_child(current)
