class_name InventorySlot
extends PanelContainer

signal selected(index: int)
signal slot_pressed(slot: InventorySlot)

var is_selected := false : set = set_selected
@onready var highlight : Control = %Highlight

@onready var icon: TextureRect = $MarginContainer/Icon
@onready var count_label: Label = $MarginContainer/Count

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	highlight.visible = is_selected


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		slot_pressed.emit(self)

func set_selected(value: bool) -> void:
	is_selected = value
	if is_node_ready():
		highlight.visible = value
	

func set_item(item: Insect) -> void:
	if item == null:
		icon.texture = null
		count_label.text = ""
		return
	icon.texture = item.icon
