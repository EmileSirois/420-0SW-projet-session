extends Node

var inventory := Inventory.new()
var insects : Array[Insect] = []

# TODO :
	# Selectionner aléatoirement des arbres qui seront availlable pour la capture
	# Lorsqu'une capture est terminée, ajouter l'insecte capturé à l'inventaire
	#  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.capture_complete.connect(capture_complete)
	fetch_insects()

func fetch_insects():
	var dir := DirAccess.open("res://ressources/insects/")
	if dir == null:
		print("Dossier insectes introuvable")
		return
	
	for file in dir.get_files():
		file = file.trim_suffix(".remap")
		var res := load("res://ressources/insects/".path_join(file))
		insects.append(res)

func rand_insect() -> int:
	return randf_range(0, insects.size() - 1)

func capture_complete():
	print("Capture complete")
	var i = rand_insect()
	inventory.add_item(insects[i], 1)
	
	#inventory.add_item()
	print(inventory.items)
	
