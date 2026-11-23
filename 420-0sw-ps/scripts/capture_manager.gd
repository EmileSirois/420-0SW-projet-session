extends Node

var inventory := Inventory.new()
@export var insects : Array[Insect] = []

# TODO :
	# Selectionner aléatoirement des arbres qui seront availlable pour la capture
	# Lorsqu'une capture est terminée, ajouter l'insecte capturé à l'inventaire
	#  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.capture_complete.connect(capture_complete)
	Events.catalog_insects.connect(catalog)
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

func capture_complete():
	inventory.add_item(insects.pick_random(), 1)
	
	var item = inventory.items[0]
	
	
func catalog():
	for item in inventory.items:
		item.collected_amount += 1
		item.discovered = true
		Events.update_catalog.emit()
		print("Vous avez catalogué un %s | Total : %d" % [item.display_name, item.collected_amount])

	inventory.empty()
