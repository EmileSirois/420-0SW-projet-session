class_name Inventory
extends Resource

@export var slot_count: int = 20
var items: Array[Insect] = []

#func _init() -> void:
	#items.resize(slot_count)
	
func _ready() -> void:
	items.resize(slot_count)

func add_item(item: Insect, amount: int = 1):
	if amount <= 0: return
	
	if items.size() == slot_count:
		return
	
	items.push_front(item)
	Events.inventory_altered.emit()
	print(item.collected_amount)
	
	if items.size() == slot_count:
		Events.alert_requested.emit("Votre inventaire est plein, vous pouvez cataloguer vos trouvailles dans la maison!")
