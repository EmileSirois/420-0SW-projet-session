class_name InventorySlot
extends PanelContainer

signal selected(index: int)

@onready var icon: TextureRect = $MarginContainer/Icon
@onready var count_label: Label = $MarginContainer/Count

func set_item(item: Insect, count: int) -> void:
	if item == null:
		icon.texture = null
		count_label.text = ""
		return
	icon.texture = item.icon
	count_label.text = str(count) if count > 1 else ""
