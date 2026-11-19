class_name InventorySlot
extends PanelContainer

signal selected(index: int)

@onready var icon: TextureRect = $MarginContainer/Icon
@onready var count_label: Label = $MarginContainer/Count

func set_item(item: Insect) -> void:
	if item == null:
		icon.texture = null
		count_label.text = ""
		return
	icon.texture = item.icon
