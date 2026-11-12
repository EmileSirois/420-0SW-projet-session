class_name Inventory
extends Resource

@export var slot_count: int = 20
var items: Array[Insect] = []


func add_item(item: Insect, amount: int = 1):
	if amount <= 0: return
	
	if items.size() == slot_count:
		return
	
	items.push_front(item)
