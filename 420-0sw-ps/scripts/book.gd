extends Control

@onready var i_slot = preload("res://scenes/inventory_slot.tscn")
@onready var grid = %InventoryGrid
@onready var inventory : Inventory = CaptureManager.inventory
@onready var left_page := $Cover/MarginContainer/Pages/Almanac/AlmanacLeftPage
@onready var right_page := $Cover/MarginContainer/Pages/Almanac/AlmanacRightPAge
@onready var flip_left_btn := %FlipLeftBtn
@onready var flip_right_btn := %FlipRightBtn

const PAGE_SCENE_PATH := "res://scenes/page.tscn"

var insects : Array
var focus : int = 0
var selected_slot : InventorySlot

func _ready() -> void:
	Events.inventory_altered.connect(update_inventory)
	Events.inventory_altered.connect(refresh_almanac) # à remplacer si tu as un signal dédié au cataloguage
	fill_grid()
	refresh_almanac()


func update_inventory() -> void:
	var slots := grid.get_children()
	var items := inventory.items
	for index in slots.size():
		var slot : InventorySlot = slots[index]

		if index < items.size() and items[index] != null:
			slot.set_item(items[index])
		else:
			slot.set_item(null)


func fill_grid() -> void:
	var slot_count = inventory.slot_count

	for i in slot_count:
		var slot : InventorySlot = i_slot.instantiate()
		grid.add_child(slot)
		slot.slot_pressed.connect(_on_slot_pressed)


func refresh_almanac() -> void:
	insects = CaptureManager.insects

	# Reste dans les limites et sur une double-page (0, 2, 4...)
	focus = clampi(focus, 0, maxi(insects.size() - 1, 0))
	focus -= focus % 2

	_clear_page(left_page)
	_clear_page(right_page)
	_add_page(left_page, focus)
	_add_page(right_page, focus + 1)

	check_nav_limit()


func _clear_page(container: Node) -> void:
	for child in container.get_children():
		if child is PageContent:
			container.remove_child(child)
			child.queue_free()


func _add_page(container: Node, index: int) -> void:
	if index >= insects.size():
		return

	var page : PageContent = load(PAGE_SCENE_PATH).instantiate()
	container.add_child(page)       # d'abord dans l'arbre, pour que ses @onready soient prêts
	page.set_item(insects[index])
	

func _on_flip_left_btn_pressed() -> void:
	focus = maxi(focus - 2, 0)
	refresh_almanac()


func _on_flip_right_btn_pressed() -> void:
	focus += 2
	refresh_almanac()

func check_nav_limit() -> void:
	var at_start := focus == 0
	var at_end := focus + 2 >= insects.size()

	flip_left_btn.disabled = at_start
	flip_left_btn.visible = not at_start
	flip_right_btn.disabled = at_end
	flip_right_btn.visible = not at_end

func _on_slot_pressed(slot: InventorySlot) -> void:
	if selected_slot == slot:
		return   # ou: désélectionner, voir plus bas

	if selected_slot:
		selected_slot.is_selected = false

	selected_slot = slot
	slot.is_selected = true
