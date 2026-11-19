extends Control

#@onready var inventory_slot : InventorySlot = $Cover/MarginContainer/TabContainer/Inventaire/PanelContainer/InventorySlot
@onready var i_slot = preload("res://scenes/inventory_slot.tscn")
@onready var grid = %InventoryGrid
@onready var inventory : Inventory = CaptureManager.inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.inventory_altered.connect(update_inventory)
	fill_grid()

func update_inventory():
	var slots := grid.get_children()
	var items := inventory.items
	for index in items.size():
		var slot : InventorySlot = slots[index]
		
		slot.set_item(items[index])


func fill_grid():
	var slot_count = inventory.slot_count
	
	for i in slot_count:
		grid.add_child(i_slot.instantiate())
	
	
	
	
	
