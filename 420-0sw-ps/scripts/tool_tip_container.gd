# script sur la racine de la scène du tooltip
extends PanelContainer

@onready var label: Label = $Label

var details := ""

func _ready() -> void:
	label.text = details
	
	
