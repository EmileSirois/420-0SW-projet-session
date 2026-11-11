extends Node

@onready var inventory : Array

# TODO :
	# Selectionner aléatoirement des arbres qui seront availlable pour la capture
	# Lorsqu'une capture est terminée, ajouter l'insecte capturé à l'inventaire
	#  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.capture_complete.connect(capture_complete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func capture_complete():
	print("Capture complete")
	inventory.push_front("Insecte")
	print(inventory)
	
