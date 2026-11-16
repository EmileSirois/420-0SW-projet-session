extends Control

#@onready var inventory_slot : InventorySlot = $Cover/MarginContainer/TabContainer/Inventaire/PanelContainer/InventorySlot
@onready var i_slot = preload("res://scenes/inventory_slot.tscn")
@onready var grid = %InventoryGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.inventory_altered.connect(update_inventory)
	fill_grid()

func update_inventory(i : Insect, c: int):
	#inventory_slot.set_item(i, c)
	pass

func fill_grid():
	var slot_count = CaptureManager.inventory.slot_count
	
	for i in slot_count:
		grid.add_child(i_slot.instantiate())
	
	
	
	
	
