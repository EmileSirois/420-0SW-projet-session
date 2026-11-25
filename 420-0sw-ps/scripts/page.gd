extends Control
class_name PageContent

var item : Insect

@onready var icon := %Icon
@onready var title := %Name
@onready var desc := %Description
@onready var discovered_check := %DiscoveredCheck
@onready var amount_text := %AmountText

func set_item(i: Insect) -> void:
	item = i
	icon.texture = i.icon
	title.text = i.display_name
	desc.text = i.description_paragraph
	
	if item.discovered:
		amount_text.text = "Quantité capturée :  %s" % i.collected_amount
		discovered_check.button_pressed = true
		icon.material = null
		
	
	
