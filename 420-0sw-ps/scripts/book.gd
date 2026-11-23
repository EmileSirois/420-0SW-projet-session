extends Control

#@onready var inventory_slot : InventorySlot = $Cover/MarginContainer/TabContainer/Inventaire/PanelContainer/InventorySlot
@onready var i_slot = preload("res://scenes/inventory_slot.tscn")
@onready var page_content = preload("res://scenes/page.tscn")
@onready var grid = %InventoryGrid
@onready var inventory : Inventory = CaptureManager.inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.inventory_altered.connect(update_inventory)
	fill_grid()
	generate_almanach_pages()

func update_inventory():
	var slots := grid.get_children()
	var items := inventory.items
	for index in slots.size():
		var slot : InventorySlot = slots[index] 
		
		if index < items.size() and items[index] != null:
			slot.set_item(items[index])
		else:
			slot.set_item(null)

func fill_grid():
	var slot_count = inventory.slot_count
	
	for i in slot_count:
		grid.add_child(i_slot.instantiate())
	
func generate_almanach_pages():
	var insects := CaptureManager.insects
	
	var almlp = $Cover/MarginContainer/Pages/Almanac/AlmanacLeftPage
	var new_page := page_content.instantiate()
	almlp.add_child(new_page)
	new_page.set_item(insects[0])
	

	
	
	
