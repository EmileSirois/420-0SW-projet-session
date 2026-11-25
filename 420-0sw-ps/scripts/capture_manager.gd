extends Node

var inventory := Inventory.new()
var tree_array : Array
var game_loop: GameLoop

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
	
func catalog():
	for item in inventory.items:
		item.collected_amount += 1
		item.discovered = true
		Events.update_catalog.emit()

	inventory.empty()
	verify_completion()

func verify_completion():
	var complete := true
	
	for i in insects:
		if !i.discovered:
			complete = false
	
	if complete:
		print("Collection terminée!")

func select_trees():
	tree_array = get_tree().get_nodes_in_group("trees")
	#for t in tree_array:
		#t.capturable = true
	var pondTrees := game_loop.pondInterractables.map(func(i): return i.get_parent() if i is Interactable else null)
	for t in pondTrees:
		t.capturable = true
		
