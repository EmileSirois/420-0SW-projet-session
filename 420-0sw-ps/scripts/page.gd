extends Control
class_name PageContent

var item : Insect

@onready var icon := %Icon
@onready var title := %Name
@onready var desc := %Description
@onready var discovered_check := %DiscoveredCheck

func _ready() -> void:
	Events.update_catalog.connect(set_discovered)

func set_item(i: Insect) -> void:
	item = i
	icon.texture = i.icon
	title.text = i.display_name
	desc.text = i.description_paragraph

func set_discovered():
	if item.discovered:
		discovered_check.button_pressed = true
		icon.material = null
	
