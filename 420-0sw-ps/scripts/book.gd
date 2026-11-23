extends Control

#@onready var inventory_slot : InventorySlot = $Cover/MarginContainer/TabContainer/Inventaire/PanelContainer/InventorySlot
@onready var i_slot = preload("res://scenes/inventory_slot.tscn")
@onready var page_content = preload("res://scenes/page.tscn")
@onready var grid = %InventoryGrid
@onready var inventory : Inventory = CaptureManager.inventory
@onready var left_page := $Cover/MarginContainer/Pages/Almanac/AlmanacLeftPage
@onready var right_page := $Cover/MarginContainer/Pages/Almanac/AlmanacRightPAge
@onready var flip_left_btn := %FlipLeftBtn
@onready var flip_right_btn := %FlipRightBtn

var insects : Array
var pages : Array
var focus : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.inventory_altered.connect(update_inventory)
	fill_grid()
	generate_almanach_pages()
	check_nav_limit()

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
	insects = CaptureManager.insects
	
	for i in insects:
		var new_page := page_content.instantiate()
		pages.append(new_page)
	
	set_visible_pages()
	
func set_visible_pages():
	# Retirer les anciennes pages sans les détruire
	for child in left_page.get_children():
		if child is PageContent:
			left_page.remove_child(child)

	for child in right_page.get_children():
		if child is PageContent:
			right_page.remove_child(child)

	# Vérifier les limites du tableau
	if focus >= pages.size():
		return

	# Ajouter les nouvelles pages
	var left_page_content = pages[focus]
	left_page.add_child(left_page_content)
	left_page_content.set_item(insects[focus])

	if focus + 1 < pages.size():
		var right_page_content = pages[focus + 1]
		right_page.add_child(right_page_content)
		right_page_content.set_item(insects[focus + 1])
	
	check_nav_limit()

func _on_flip_left_btn_pressed() -> void:
	if focus > 0:
		focus -= 2
	set_visible_pages()

func _on_flip_right_btn_pressed() -> void:
	focus += 2
	set_visible_pages()

func check_nav_limit() -> void:
	if focus == 0:
		flip_left_btn.disabled = true
		flip_left_btn.visible = false
	else:
		flip_left_btn.disabled = false
		flip_left_btn.visible = true
	
	if focus >= pages.size() - 2:
		flip_right_btn.disabled = true
		flip_right_btn.visible = false
	else:
		flip_right_btn.disabled = false
		flip_right_btn.visible = true
